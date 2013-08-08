class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
    exclude_current_user
    sort_users
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
      redirect_to new_user_path and return
    end
    render "new"
  end

  # private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def exclude_current_user
    @users = @users.reject { |user| current_user == user }
  end

  def sort_users
    @users = @users.sort
  end

end
