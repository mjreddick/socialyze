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
    user_hash[:num_followers] = omniauth_hash.extra.raw_info.followers_count
    user_hash[:total_num_tweets] = omniauth_hash.extra.raw_info.statuses_count

    user_hash
  end

  # 15 requests per 15-minute window
  # Return up to ____ followers
  def get_follower_ids(access_token, screen_name)
    # Only get 100 followers so that the rate limit shouldn't be an issue
    access_token.get("https://api.twitter.com/1.1/followers/ids.json?screen_name=#{screen_name}&count=100").body
  end

  # 180 requests per 15-minute window
  # Return only up to 3200 recent tweets per user
  # In reponse, user's retweeted tweets are excluded. Replies to user's tweets are excluded.
  #   Maximum of _____ tweets are returned per request
  def get_tweets(access_token, twitter_uid)
    access_token.get("https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=#{twitter_uid}&count=200&exclude_replies=true&include_rts=false").body
  end

  def get_tweet_hour(item)
    time_stamp = item["created_at"]
    utc_offset = item["user"]["utc_offset"]
    if time_stamp.blank? || utc_offset.blank?
      return nil
    else
      offset = utc_offset.to_i
      time = DateTime.parse(time_stamp)
      time = time + offset.second
      return time.hour
    end
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