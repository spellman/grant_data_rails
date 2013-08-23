class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @user  = User.new
    @users = User.all
    authorize @user
    authorize @users
    paginate_users
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
      present_authorization_error_to_non_admin_users
    end
    authorize @user
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update_attributes(user_params) ? save_succeeded : render("show")
  end

  def destroy
    begin
      user = User.find params[:id]
      authorize user
      user.destroy
      delete_succeeded
    rescue ActiveRecord::RecordNotFound
      delete_failed
    end
    redirect_to :users
  end

  # private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def save_succeeded
    flash[:success] = "Saved #{@user.email}"
    redirect_after_save
  end

  def redirect_after_save
    current_user.admin? ? redirect_to(:users) : redirect_to(:records)
  end

  def save_failed
    paginate_users
    render "index"
  end

  def present_authorization_error_to_non_admin_users
    raise Pundit::NotAuthorizedError unless current_user.admin?
  end

  def delete_succeeded
    flash[:success] = "User deleted"
  end

  def delete_failed
    flash[:notice] = "User to be deleted did not exist. The browser's \"back\" button may have been used to display a user that had already been deleted."
  end

  def paginate_users
    @users = User.page(params[:page]).per(13).order("created_at ASC")
  end

end
