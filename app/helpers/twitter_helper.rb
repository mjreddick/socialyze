module TwitterHelper

  # Check out this website. It helped me sort of understand OAuth and what methods to use
  # http://www.railstips.org/blog/archives/2009/03/29/oauth-explained-and-what-it-is-good-for/

  def get_tweets(omniAuth)
    # OmniAuth Hash contains the OAutch access token object
    access_token = omniAuth.extra.access_token

    # Use the access token to make the api call
    # https://dev.twitter.com/rest/reference/get/statuses/user_timeline
    tweets = access_token.get("/1.1/statuses/user_timeline.json?screen_name=#{omniAuth.extra.raw_info.screen_name}").body
  end

end