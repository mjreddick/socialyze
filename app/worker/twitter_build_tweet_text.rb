class TwitterBuildTweetText
  include Sidekiq::Worker
  include TwitterHelper

  # When calling worker, pass in request.env['omniauth.auth'].credentials.token/secret
  def perform(info_hash)
    access_token = create_access_token(info_hash["token"], info_hash["secret"])
    tweets = access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{info_hash["screen_name"]}&count=20&exclude_replies=true&include_rts=false").body

    JSON.parse(response.body).each do |item|
        # item["text"]
        # Add code to save each tweet to tweet_text table
    end

  end
end