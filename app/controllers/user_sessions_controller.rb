# User sessions controller
class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    if @user = login(params[:email], params[:password], params[:remember_me])
      redirect_to root_url, success: 'Вы вошли'
    else
      flash.now[:error] = 'Email или пароль неправильные'
      render :new
    end
  end

  def destroy
    logout
    redirect_to home_about_path, notice: 'Вы вышли'
  end
end
