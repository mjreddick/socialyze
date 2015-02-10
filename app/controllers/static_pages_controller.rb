class StaticPagesController < ApplicationController

  def home
    # Display the returned hash in the view
    @test = request.env['omniauth.auth']
  end
end
