class TwitterBuildUserData
  include Sidekiq::Worker
  include TwitterHelper
  sidekiq_options :retry => 1

  def perform(info_hash, user_id)
    # Create user access_token
    access_token = create_access_token(info_hash["token"], info_hash["secret"])
 
    user = User.find(user_id) 

    ##### Add user's twitter account to twitter_account table #####
    account = user.build_twitter_account(twitter_uid: info_hash["uid"],token: info_hash["token"],secret: info_hash["secret"],username: info_hash["screen_name"],time_zone: info_hash["time_zone"])

    account.save!
    user.save!

    #### Add tweets to tweets table #####
    # get the response body with a user's tweets
    user_tweets = get_tweets(access_token, info_hash["uid"])

    puts "About to parse tweets"

    JSON.parse(user_tweets).each do |item|
      tweet = user.twitter_account.tweets.build
      tweet.tweet_text = item["text"]
      tweet.twitter_tweet_id = item["id_str"]

      if tweet.save!
        ##### Build words table #####
        # if the save succeeded then the tweet is unique
        # break the tweet up into words and save those words
        words = split_tweet_into_words(item["text"])
        # puts tweet_words.inspect
        words.each do |word|
          puts word
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
        # Create twitter_account and relationships
        follower_account = user.twitter_account.followers.create!(twitter_uid: first_tweet["user"]["id_str"], username: first_tweet["user"]["screen_name"])

        puts "Created follower account"

        if follower_account
          # if the follower's twitter account is saved then walk through all their tweets
          parsed_follower_tweets.each do |item|
            tweet = follower_account.tweets.build
            tweet.tweet_text = item["text"]
            tweet.twitter_tweet_id = item["id_str"]

            if tweet.save
              ##### Build words table #####
              # if the save succeeded then the tweet is unique
              # break the tweet up into words and save those words
              words = split_tweet_into_words(item["text"])
              words.each do |word|
                # save each word unless it is a stop word
                follower_account.tweet_words.create(word: word) unless StopWord.find_by(word: word)
              end
            end
          end
        end
      end
    end # loop through followers
  end # perform
end # class