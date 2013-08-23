class ApplicationController < ActionController::Base
  include Pundit
  before_action :authenticate_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  def authenticate_user
    redirect_to signin_path, notice: "Please sign in." unless signed_in?
  end

  def signed_in?
    !current_user.nil?
  end
  helper_method :signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def user_not_authorized
    log_unauthorized_access_attempt
    flash[:danger] = "Whoa, there. You aren't authorized to perform that action."
    redirect_to :records
  end

  def log_unauthorized_access_attempt
    p "USER #{current_user.email} ATTEMPTED TO ACCESS #{request.env["REQUEST_URI"]}"
  end
end
