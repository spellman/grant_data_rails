class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @user  = User.new
    @users = User.all
    authorize @user
    authorize @users
    paginate_users
  end

  def new
    @user = User.new
    authorize @user
  end

  def create
    @user = User.new user_params
    authorize @user
    @user.save ? save_succeeded : save_failed
  end

  def show
    begin
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound
      raise Pundit::NotAuthorizedError
    end
    authorize @user
  end

  # private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def save_succeeded
    flash[:success] = "Created user #{@user.email}"
    redirect_to users_path
  end

  def save_failed
    paginate_users_except_current
    render "index"
  end

  def paginate_users
    @users = User.order("created_at DESC").paginate(page: params[:page])
  end

end
