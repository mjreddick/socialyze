module TwitterHelper

  ############################
  # Testing omniauth/oauth 
  ############################
  def get_tweets(omniAuth)
    # OmniAuth Hash contains the OAutch access token object
    access_token = omniAuth.extra.access_token

    # Use the access token to make the api call
    # https://dev.twitter.com/rest/reference/get/statuses/user_timeline
    tweets = access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{omniAuth.extra.raw_info.screen_name}&count=200&exclude_replies=true&include_rts=false").body
  end

  #####################
  # Build OAuth Objects
  ######################
  # Create an OAuth Consumer object
  def build_OAuth_consumer
    OAuth::Consumer.new(ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], {site: 'https://api.twitter.com'})
  end

  # Create an OAuth Access Token object
  def create_access_token(token, secret)
    consumer = build_OAuth_consumer
    OAuth::AccessToken.new(consumer, token, secret)
  end

  #####################
  # Worker related methods
  ######################
  def build_hash(omniauth_hash)
    user_hash               = Hash.new()
    user_hash[:uid]         = omniauth_hash.uid
    user_hash[:screen_name] = omniauth_hash.info.nickname
    user_hash[:location]    = omniauth_hash.info.location
    user_hash[:token]       = omniauth_hash.credentials.token
    user_hash[:secret]      = omniauth_hash.credentials.secret
    user_hash[:name]        = omniauth_hash.info.name
    user_hash[:time_zone]   = omniauth_hash.extra.time_zone

    user_hash
  end

  # 180 requests per 15-minute window
  # Return only 3200 recent tweets
  def send_tweets_request(access_token, screen_name)
    # # Production
    # access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=200&exclude_replies=true&include_rts=false").body

    # Development
    # access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=100&exclude_replies=true&include_rts=false").body
        access_token.get("/1.1/statuses/user_timeline.json?screen_name=angularjs&count=100&exclude_replies=true&include_rts=false").body
  end

  # 15 requests per 15-minute window
  def send_followers_request(access_token, screen_name)
    # When in production
    # access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=#{screen_name}&count=5000").body

    # Development
    # access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=#{screen_name}&count=50").body
    access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=angularjs&count=50").body
  end


end