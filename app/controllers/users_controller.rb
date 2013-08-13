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
    @user.save ? save_succeeded(:create) : save_failed
  end

  def show
    begin
      @user = User.find params[:id]
    rescue ActiveRecord::RecordNotFound
      raise Pundit::NotAuthorizedError
    end
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update_attributes(user_params) ? save_succeeded(:update) : render("show")
  end

  def destroy
    user = User.find params[:id]
    authorize user
    user.destroy
    flash[:success] = "User deleted"
    redirect_to :users
  end

  # private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def save_succeeded type_sym
    flash[:success] = "#{save_action(type_sym)} #{@user.email}"
    redirect_to :users
  end

  def save_failed
    paginate_users
    render "index"
  end

  def save_action type_sym
    case type_sym
    when :create then "Saved"
    when :update then "Updated"
    end
  end

  def paginate_users
    @users = User.paginate(page: params[:page]).order("created_at ASC")
  end

end
