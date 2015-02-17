class TwitterBuildUserData
  include Sidekiq::Worker
  include TwitterHelper

  def perform(info_hash, user_id)
    # Create user access_token
    access_token = create_access_token(info_hash["token"], info_hash["secret"])

    ##### Add user to twitter_account table #####
    user = User.find(user_id) # production
    # user = User.find(User.all.first.id) # development

    # 
    puts "INFO HASH >>>>>>>>>>>>>>>>"
    puts info_hash
    puts "END INFO HASH <<<<<<<<<<<<<<<<"

    user.build_twitter_account(
      twitter_uid: info_hash["uid"],
      token: info_hash["token"],
      secret: info_hash["secret"],
      username: info_hash["screen_name"],
      time_zone: info_hash["time_zone"]
      ).save

    puts "OUTPUT USER >>>>>>>>>>>>>>>>>>>>>>"
    p user
    puts "USER DONE <<<<<<<<<<<<<<<<<<<<<<<<<"
    #### Build tweets table #####
    
    response_body = send_tweets_request(access_token, info_hash["screen_name"])
    
    # for dev
    puts "BEFORE GET_TWEETS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
    puts get_tweets(access_token, info_hash["uid"])
    puts "AFTER GET_TWEETS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

    JSON.parse(response_body).each do |item|
      puts "BEFORE BUILD TWEETS >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      tweet = user.twitter_account.tweets.build
      puts tweet
      puts "AFTER BUILD TWEETS <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"
      tweet.tweet_text = item["text"]
      tweet.twitter_tweet_id = item["id_str"]
      puts "BEFORE TWEET.SAVE >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
      if tweet.save
        puts "INSIDE THE IF >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
            ##### Build words table #####
        # if the save succeeded then the tweet is unique
        # break the tweet up into words and save those words
        words = split_tweet_into_words(item["text"])
        words.each do |word|
          # save each word unless it is a stop word
          user.twitter_account.tweet_words
            .create(word: word) unless StopWord.find_by(word: word)
        end
      end
      puts "AFTER THE IF <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<"

      # item["text"] <- to grab each tweet
      # item["created_at"] <- format "day month date time" ("Wed Feb 11 23:57:10 +0000 2015")
      # item["id_str"] <- id(type String) of particular tweet
      # item["retweet_count"] <- count on how many times it was retweeted
      # item["entities"]["hashtags"]
      # item["entities"]["user_mentions"]

      # Add code to save each tweet to tweet_text table
    end











    ##### Build followers table #####
    ##### Each follower - add to twtter account table, tweets, words #####
    response_body = send_followers_request(access_token, info_hash["screen_name"])

    JSON.parse(response_body)["ids"].each do |follower_id|
      # Create twitter_account and relationships
      user.twitter_account.followers.create(twitter_id: follower_id)

      # Add followers' tweets to table
      # Add followers' words to table

      # response_body = get_follower_tweets(access_token, follower_id)
    end



    ##### Run analysis #####



  end
end