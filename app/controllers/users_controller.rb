class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new user_params
    authorize @user
    if @user.save
      flash[:success] = "Saved"
      redirect_to new_user_path
    else
      render "new"
    end
  end

  # private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
