class StaticPagesController < ApplicationController
  include TwitterHelper
  # include InstagramHelper # refactor into classes

  def home
    @user = User.new
    if logged_in?
    @current_user = current_user
    end
    # Display the returned hash in the view
    @test = request.env['omniauth.auth']

    if request.env['omniauth.auth'] != nil && params[:provider] == 'twitter'
      # Workers
      user_hash = build_hash(request.env['omniauth.auth'])
      # AnalyticsNotifier.send_data_ready_email(@current_user).deliver
      TwitterBuildUserData.perform_async(user_hash, current_user.id) # production
      # TwitterBuildUserData.perform_async(user_hash, 1)
      redirect_to users_path
    end

    # if request.env['omniauth.auth'] != nil && params[:provider] == 'instagram'
    #   # @instagram_feed = get_instagram_feed(request.env['omniauth.auth'])
    #   omniAuth = request.env['omniauth.auth']
    #   user_hash = build_hash(request.env['omniauth.auth'])

    #   access_token = request.env['omniauth.auth'].credentials.token

    #   InstagramBuildUserData.perform_async(access_token)
    # end
  end
end
