class UsersController < ApplicationController
  include TwitterHelper

  def index

  end

  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def results
    # Grab data from twitter results table
    # @results = Results.find(current_user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id.to_s
      redirect_to user_path(@user), notice: 'Thanks for Signing up!'
    else
      render :new, alert: "Oops something was wrong, please try again."
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(user_params)
      redirect_to root_path,  notice: "#{@user.name}'s info updated."
    else
      render "edit", alert: "Unable to edit User"
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Sad to see you go."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
