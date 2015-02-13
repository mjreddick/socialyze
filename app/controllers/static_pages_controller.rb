class StaticPagesController < ApplicationController
  include TwitterHelper

  def home
    # Display the returned hash in the view
    @test = request.env['omniauth.auth']

    if request.env['omniauth.auth'] != nil && params[:provider] == 'twitter'
      # Workers
      user_hash = build_hash(request.env['omniauth.auth'])
      # TwitterBuildUserData.perform_async(user_hash, current_user.id)
      TwitterBuildUserData.perform_async(user_hash, 1)
    end
  end
end
