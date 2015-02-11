class StaticPagesController < ApplicationController
  include TwitterHelper

  def home
    # Display the returned hash in the view
    @test = request.env['omniauth.auth']

    if request.env['omniauth.auth'] != nil && params[:provider] == 'twitter'
      # For testing purpose. Delete when workers are working
      @tweets = get_tweets(request.env['omniauth.auth'])

      # Workers
      user_hash = build_hash(request.env['omniauth.auth'])
      TwitterBuildTweetText.perform_async(user_hash)
      # Add code to start superworker
    end
  end
end
