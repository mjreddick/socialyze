module InstagramHelper

  # Generic Instagram call for testing purposes
  def get_instagram_feed(omniAuth)
    access_token = omniAuth.credentials.token

    feed = HTTParty.get("https://api.instagram.com/v1/users/self/feed?access_token=#{access_token}").body

    feed
  end

  # Build a hash to save info to DB eventually
  def build_hash(omniauth_hash)
    user_hash = Hash.new
    user_hash[:token] = omniauth_hash.credentials.token
    user_hash[:name] = omniauth_hash.info.name
    user_hash[:nickname] = omniauth_hash.info.nickname
    user_hash[:uid] = omniauth_hash.info.uid
    user_hash[:image] = omniauth_hash.info.image

    user_hash
  end

end
