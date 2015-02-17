class InstagramBuildUserData
  include Sidekiq::Worker
  include InstagramHelper

  INSTAGRAM_API_USER_FEED_URL = "https://api.instagram.com/v1/"

  def perform(access_token)
    user_feed = HTTParty.get("#{INSTAGRAM_API_USER_FEED_URL}users/self/feed?access_token=#{access_token}").body

    # Output user_feed to sidekiq for until DB tables are set up
    puts user_feed
  end

end
