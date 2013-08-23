class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def new
  end

  def create
    user = User.find_by_email params[:email]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to :records
    else
      flash.now[:danger] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end
