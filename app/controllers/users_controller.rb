class UsersController < ApplicationController
  after_action :verify_authorized

  def index
    @user  = User.new
    authorize @user

    respond_to do |format|
      format.html {
        @users = User.all
        authorize @users
        paginate_users
      }
      format.js
    end
  end

  def create
    @user = User.new user_params
    authorize @user
    @user.save ? save_succeeded : save_failed
  end

  def edit
    begin
      @user = User.find(params[:id])
      authorize @user
    rescue ActiveRecord::RecordNotFound
      if current_user.admin?
        skip_authorization
        flash[:warning] = "User to be edited does not exist."
        redirect_to users_path and return
      else
        raise Pundit::NotAuthorizedError and return
      end
    end

    @cancel_edit_path = current_user.admin? ? users_path : patients_path

    respond_to do |format|
      format.html { @cancel_link_remote = false}
      format.js { @cancel_link_remote = true}
    end
  end

  def update
    @user = User.find params[:id]
    authorize @user
    @user.update_attributes(user_params) ? save_succeeded : render("edit")
  end

  def destroy
    begin
      user = User.find params[:id]
      authorize user
      user.destroy
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
    redirect_after_save
  end

  def redirect_after_save
    current_user.admin? ? redirect_to(:users) : redirect_to(:records)
  end

  def save_failed
    paginate_users
    render "index"
  end

  def delete_failed
    flash[:warning] = "User to be deleted did not exist. The browser's \"back\" button may have been used to display a user that had already been deleted."
  end

  def paginate_users
    @users = User.page(params[:page]).per(13).order("created_at ASC")
  end
end
