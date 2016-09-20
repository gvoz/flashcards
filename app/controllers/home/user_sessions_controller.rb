# User sessions controller
module Home
  class UserSessionsController < ApplicationController
    def new
      @user = User.new
    end

    def create
      if @user = login(params[:email], params[:password], params[:remember_me])
        flash[:success] = t('.success')
        redirect_to root_url
      else
        flash[:error] = t('.error')
        render :new
      end
    end

    def destroy
      logout
      redirect_to about_path, notice: t('.success')
    end
  end
end
