class StaticPagesController < ApplicationController
  include TwitterHelper
  include InstagramHelper

  def home
    # Display the returned hash in the view
    @test = request.env['omniauth.auth']

    if request.env['omniauth.auth'] != nil && params[:provider] == 'twitter'
      # Workers
      user_hash = build_hash(request.env['omniauth.auth'])
      # TwitterBuildUserData.perform_async(user_hash, current_user.id)
      TwitterBuildUserData.perform_async(user_hash, 1)
    end

    if request.env['omniauth.auth'] != nil && params[:provider] == 'instagram'
      @instagram_feed = get_instagram_feed(request.env['omniauth.auth'])
    end
  end
end
