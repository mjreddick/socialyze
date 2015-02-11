class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Thanks for Signing up!'
    else
      render :new, alert: "Oops something was wrong, please try again."
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
