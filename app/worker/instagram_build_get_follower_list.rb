class InstagramBuildFollowersList
  include Sidekiq::Worker
  include InstagramHelper

  INSTAGRAM_API_URL = 'https://api.instagram.com/v1/'

  # When calling a worker, pass it the prebuild request hash
  def perfom(info_hash)
    access_token = create_instagram_access_token(info_hash["token"], info_hash["secret"])
    user_feed = access_token.get("#{INSTAGRAM_API_URL}users/self/feed").body

    puts user_feed

    JSON.parse(response.body).each do |item|

    end

  end

end
