module InstagramHelper

  def get_instagram_feed(omniAuth)
    access_token = omniAuth.credentials.token

    feed = HTTParty.get("https://api.instagram.com/v1/users/self/feed?access_token=#{access_token}").body

    feed
  end

  def build_instagram_OAuth_consumer
    OAuth::Consumer.new(ENV['INSTAGRAM_ID'], ENV['INSTAGRAM_SECRET'],
                        {site: 'https://api.instagram.com/v1/'})
  end

  def create_instagram_access_token(token, secret)
    consumer = build_OAuth_consumer
    OAuth::AccessToken.new(consumer, token, secret)
  end

end
