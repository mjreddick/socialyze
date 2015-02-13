class TwitterBuildUserData
  include Sidekiq::Worker
  include TwitterHelper

  def perform(info_hash, user_id)
    # Create user access_token
    access_token = create_access_token(info_hash["token"], info_hash["secret"])

    ##### Add user to twitter_account table #####
    # check TwitterHelper module to see keys of info_hash

    ##### Build tweets table #####
    response_body = send_tweets_request(access_token, info_hash["screen_name"])

    JSON.parse(response_body).each do |item|
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
        # Add to twitter_follower_relationship table
        # Create twitter_account for follower if he/she doesn't exist in it yet
        # Add to tweet text/word tables?


        # Followers' tweets. Need to parse 
        # response_body = get_follower_tweets(access_token, follower_id)
    end





    





    ##### Run analysis #####


  end
end