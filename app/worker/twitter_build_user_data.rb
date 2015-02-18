class TwitterBuildUserData
  include Sidekiq::Worker
  include TwitterHelper
  sidekiq_options :retry => 1

  def perform(info_hash, user_id)
    # Create user access_token
    access_token = create_access_token(info_hash["token"], info_hash["secret"])

    ##### Add user to twitter_account table #####
    # user = User.find(user_id) # production
    user = User.find(User.all.first.id) # development

    # 
    user.build_twitter_account(twitter_id: info_hash["uid"], token: info_hash["token"], secret: info_hash["secret"]).save

    #### Build tweets table #####
    
    response_body = send_tweets_request(access_token, info_hash["screen_name"])

    JSON.parse(response_body).each do |item|
        tweet = user.twitter_account.tweets.build
        tweet.tweet_text = item["text"]
        # tweet.save


        # item["text"] <- to grab each tweet
        # item["created_at"] <- format "day month date time" ("Wed Feb 11 23:57:10 +0000 2015")
        # item["id_str"] <- id(type String) of particular tweet
        # item["retweet_count"] <- count on how many times it was retweeted
        # item["entities"]["hashtags"]
        # item["entities"]["user_mentions"]

        # Add code to save each tweet to tweet_text table
    end



    ##### Build words table #####







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