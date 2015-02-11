class TwitterBuildUserData
  include Sidekiq::Worker
  include TwitterHelper

  # When calling worker, pass in request.env['omniauth.auth'].credentials.token/secret
  def perform(info_hash, user_id)
    # Create user access_token
    access_token = create_access_token(info_hash["token"], info_hash["secret"])

    ##### Add user to twitter_account table #####

    ##### Build tweets table #####
    response_body = send_tweets_request(access_token, info_hash["screen_name"])

    JSON.parse(response_body).each do |item|
        # item["text"]
        # Add code to save each tweet to tweet_text table
    end

    ##### Build word table #####
      # 

    ##### Build followers table #####
    response_body = send_followers_request(access_token, info_hash["screen_name"])

    JSON.parse(response_body)["ids"]

      # Code to add follower ids into follower table

    ##### Each follower - add to twtter account table, tweets, words #####


    ##### Run analysis #####


  end
end