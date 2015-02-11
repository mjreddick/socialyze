class SessionsController < ApplicationController
  def new
  end
  def create
    user = User.where(email: params[:login][:email]).first
    if user && user.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: "Thanks for logging in"
    else
      redirect_to login_path, alert: 'Check your email and password and try again.'
    end
  end
  
  def destroy
  end
end