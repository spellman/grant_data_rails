class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @users = User.all
    authorize @users
    paginate_users_except_current
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

  def paginate_users_except_current
    @users = User.where.not(email: current_user.email)
                 .order("created_at DESC")
                 .paginate(page: params[:page])
  end

end
