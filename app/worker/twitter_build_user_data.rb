class TwitterBuildUserData
  include Sidekiq::Worker
  include TwitterHelper
  include TwitterResultHelper
  sidekiq_options :retry => 1

  def perform(info_hash, user_id)
    # Create user access_token
    access_token = create_access_token(info_hash["token"], info_hash["secret"])
 
    user = User.find(user_id) 

    # Check if a twitter account with the user's uid already exists

    account = TwitterAccount.find_by(twitter_uid: info_hash["uid"])

    if account
      # the user's twitter account already exists on our site
      # so connect the user to the their twitter account
      account.user = user
      
    else
      # The user does not already have a twitter account saved in our database so make one
      account = user.build_twitter_account(twitter_uid: info_hash["uid"])
      
    end
    account.token = info_hash["token"]
    account.secret = info_hash["secret"]
    account.time_zone = info_hash["time_zone"]
    account.username = info_hash["screen_name"]
    account.num_followers = info_hash["num_followers"]
    account.total_num_tweets = info_hash["total_num_tweets"]

    account.save


    #### Add tweets to tweets table #####
    # get the response body with a user's tweets
    user_tweets = get_tweets(access_token, info_hash["uid"])

    puts "About to parse tweets"

    JSON.parse(user_tweets).each do |item|
      tweet = user.twitter_account.tweets.build
      tweet.tweet_text = item["text"]
      tweet.twitter_tweet_id = item["id_str"]
      tweet.character_count = item["text"].length
      tweet.hour = get_tweet_hour(item)

      if tweet.save
        ##### Build words table #####
        # if the save succeeded then the tweet is unique
        # break the tweet up into words and save those words
        words = split_tweet_into_words(item["text"])

        words.each do |word|
          # save each word unless it is a stop word
          user.twitter_account.tweet_words.create(word: word) unless StopWord.find_by(word: word)
        end
      end

      # item["text"] <- to grab each tweet
      # item["created_at"] <- format "day month date time" ("Wed Feb 11 23:57:10 +0000 2015")
      # item["id_str"] <- id(type String) of particular tweet
      # item["retweet_count"] <- count on how many times it was retweeted
      # item["entities"]["hashtags"]
      # item["entities"]["user_mentions"]

    end

    puts "Done parsing tweets"

    ##### Build followers table #####
    ##### Each follower - add to twitter account table, tweets, words #####
    followers_data = get_follower_ids(access_token, info_hash["screen_name"])

    JSON.parse(followers_data)["ids"].each do |follower_id|
      
    puts "Getting followers"

      # Get the tweets for that follower
      follower_tweets = get_tweets(access_token, follower_id)
      parsed_follower_tweets = JSON.parse(follower_tweets)

      # Only save a follower if they have tweets
      #   This is done to save an api call to get the additional info needed
      #   for that user such as username
      # If the returned data is not an array then most likely you do not have access to that user's tweets
      unless parsed_follower_tweets.blank? || parsed_follower_tweets.class != Array
        # Use the data from the first tweet to build the follower's twitter account
        first_tweet = parsed_follower_tweets.first

        # Check if follower's account already exists in our db
        follower_account = TwitterAccount.find_by(twitter_uid: first_tweet["user"]["id_str"])

        if follower_account
          # the follower's twitter account already exists
          # assume we already have tweets for this account so don't get them
          # check if the connection between user and follower already exists
          connection = TwitterFollowerRelationship.find_by(followee: user.twitter_account, follower: follower_account)
          unless connection
            # if the connection doesn't exist then create it
            TwitterFollowerRelationship.create(followee: user.twitter_account, follower: follower_account)
          end
          
        else
          # the follower's twitter account does not exist

          # Create twitter_account and relationships
          follower_account = user.twitter_account.followers.create(twitter_uid: first_tweet["user"]["id_str"], username: first_tweet["user"]["screen_name"], num_followers: first_tweet["user"]["followers_count"], total_num_tweets: first_tweet["user"]["statuses_count"])

          puts "Created follower account"

          if follower_account
            # if the follower's twitter account is saved then walk through all their tweets
            parsed_follower_tweets.each do |item|
              tweet = follower_account.tweets.build
              tweet.tweet_text = item["text"]
              tweet.twitter_tweet_id = item["id_str"]
              tweet.character_count = item["text"].length
              tweet.hour = get_tweet_hour(item)

              if tweet.save
                ##### Build words table #####
                # if the save succeeded then the tweet is unique
                # break the tweet up into words and save those words
                words = split_tweet_into_words(item["text"])
                words.each do |word|
                  # save each word unless it is a stop word
                  follower_account.tweet_words.create(word: word) unless StopWord.find_by(word: word)
                end # loop through follower's tweet's words
              end # if the tweet saved
            end # looping through a followers tweets
          end # if the follower's account saved
        end # if/else follower already existed
      end # unless to check if the returned follower data is good
    end # loop through followers

    # Make the twitter_results for this user
    result = user.build_twitter_result
    # add the results to the table
    result.most_used_words = get_users_most_used_words(user).to_json
    result.least_user_words = get_users_least_used_words(user).to_json
    result.early_bird = calculate_early_bird(user)
    result.avg_tweet_length = avg_tweet_length(user)
    result.num_followers = num_followers(user)
    result.total_tweets = total_tweets(user)
    result.followers_most_used_words = get_followers_most_used_words(user).to_json
    result.followers_least_used_words = get_followers_least_used_words(user).to_json
    result.followers_avg_tweet_length = get_followers_avg_tweet_length(user)
    result.followers_avg_num_followers = followers_avg_num_followers(user)
    result.followers_avg_total_tweets = followers_avg_total_tweets(user)
    result.char_per_tweet = char_per_tweet(user).to_json

    # save the results
    result.save
    
    # Send email to user about their results being ready
    AnalyticsNotifier.send_data_ready_email(user).deliver

  end # perform
end # class





