class StaticPagesController < ApplicationController
  include TwitterHelper

  def home
    # Display the returned hash in the view
    @test = request.env['omniauth.auth']

    if request.env['omniauth.auth'] != nil && params[:provider] == 'twitter'
      @tweets = get_tweets(request.env['omniauth.auth'])
    end
  end
end
