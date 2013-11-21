class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def authenticate_user
    unless signed_in?
      request_sign_in
      redirect_to signin_path
    end
  end

  def request_sign_in
    flash[:warning] = "Please sign in."
  end

  def signed_in?
    !current_user.nil?
  end
  helper_method :signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_not_authorized exception
    if attempt_to_delete_self?
      flash[:danger] = "You can't delete yourself."
      redirect_to :users
    else
      flash[:danger] = "Sorry, you aren't authorized to perform that action."
      redirect_to :patients
    end
  end

  def attempt_to_delete_self?
    request.request_method.downcase == "delete" &&
      request.filtered_parameters["id"] == current_user.id.to_s
  end
end
