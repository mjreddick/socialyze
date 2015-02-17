module TwitterHelper

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
  # Return only up to 3200 recent tweets per user
  # In reponse, user's retweeted tweets are excluded. Replies to user's tweets are excluded.
  #   Maximum of _____ tweets are returned per request
  def send_tweets_request(access_token, screen_name)
    # # Production
    # access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=200&exclude_replies=true&include_rts=false").body

    # Development
    # access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{screen_name}&count=100&exclude_replies=true&include_rts=false").body
    access_token.get("/1.1/statuses/user_timeline.json?screen_name=katyperry&count=200&exclude_replies=true&include_rts=false").body
  end

  # 15 requests per 15-minute window
  # Return up to ____ followers
  def send_followers_request(access_token, screen_name)
    # When in production
    # access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=#{screen_name}&count=5000").body

    # Development
    # access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=#{screen_name}&count=50").body
    access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=TheEllenShow&count=10").body
  end

  # Same request restrains as send_tweets_request method because
  # using the same access_token
  def get_follower_tweets(access_token, follower_id)
    access_token.get("https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=#{follower_id}&count=200&exclude_replies=true&include_rts=false").body
    # access_token.get("https://api.twitter.com/1.1/followers/ids.json?user_id=#{follower_id}&count=50").body
  end

  def get_tweets(access_token, twitter_uid)
    access_token.get("https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=#{twitter_uid}&count=200&exclude_replies=true&include_rts=false")
  end

  def split_tweet_into_words(tweet_text)
    # regex to detect links
    link_regex = /(http)\S*/i
    # regex to detect hashtags
    hashtag_regex = /\W#\w*/
    # regex to detect mentions
    mention_regex = /\W@\w*/

    # replace each link with a space
    tweet_text = tweet_text.gsub(link_regex, " ")
    # replace each hashtaged word with a space
    tweet_text = tweet_text.gsub(hashtag_regex, " ")
    # replace each mention with a space
    tweet_text = tweet_text.gsub(mention_regex, " ")

    # Remove capitalization and split based on none word characters
    word_array = tweet_text.downcase.split(/\W+/)

    # Remove any single letter words and return the array of words
    word_array.reject { |word| word.length < 2 }
  end

end