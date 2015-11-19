class UsersController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  after_action :verify_authorized

  def index
    @user = User.new
    authorize(@user)

    respond_to do |format|
      format.html {
        @users = User.all
        authorize(@users)
        paginate_users
      }
      format.js
    end
  end

  def create
    @user = User.new(user_params)
    authorize(@user)
    if @user.save
      redirect_after_save
    else
      paginate_users
      render(template: "users/index")
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize(@user)
    respond_to do |format|
      format.html { render(template: "users/edit",
                           locals: {cancel_edit_path: cancel_edit_path,
                                    cancel_link_remote: false}) }
      format.js { render(template: "users/edit",
                         locals: {cancel_edit_path: cancel_edit_path,
                                  cancel_link_remote: true}) }
    end
  end

  def update
    @user = User.find(params[:id])
    authorize(@user)
    if @user.update_attributes(user_params)
      redirect_after_save
    else
      render(template: "users/edit",
             locals: {cancel_edit_path: cancel_edit_path,
                      cancel_link_remote: false})
    end
  end

  def destroy
    user = User.find(params[:id])
    authorize(user)
    user.destroy
    redirect_to(users_path)
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def record_not_found
    if current_user.admin?
      skip_authorization
      flash[:warning] = "The requested user was not found. Has the user been created? Has the user been deleted? (Another admin may have deleted the user or the browser's \"back\" button may have been used to display a user who had already been deleted.)"
      redirect_to(users_path) and return
    else
      flash[:danger] = "Sorry, you aren't authorized to perform that action."
      redirect_to(patients_path)
    end
  end

  def cancel_edit_path
    cancel_edit_path = current_user.admin? ? users_path : patients_path
  end

  def redirect_after_save
    current_user.admin? ? redirect_to(users_path) : redirect_to(records_path)
  end

  def paginate_users
    @users = User.page(params[:page]).per(14).order("created_at ASC")
  end
end
