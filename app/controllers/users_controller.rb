class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id.to_s
      redirect_to root_path, notice: 'Thanks for Signing up!'
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
    session.delete[:user_id]
    redirect_to root_path, notice: "Sad to see you go."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
