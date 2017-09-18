class UsersController < ApplicationController

  before_action :logged_in_user, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  # confirms a user is logged in
  def logged_in_user
    redirect_to login_path unless params[:id].to_i == current_user.id
  end
end
