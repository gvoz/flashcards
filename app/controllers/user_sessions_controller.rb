# User sessions controller
class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      flash[:success] = t(:login_success)
      redirect_to root_url
    else
      flash[:error] = t(:login_error)
      render :new
    end
  end

  def destroy
    logout
    redirect_to home_about_path, notice: t(:logout_success)
  end
end
