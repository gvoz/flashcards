module Dashboard
  # User Class
  class UsersController < Dashboard::ApplicationController
    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(user_params)
      if @user.save
        auto_login(@user)
        flash[:success] = t('.success')
        redirect_to root_path
      else
        render :new
      end
    end

    def update
      @user = User.find(params[:id])

      if @user.update(user_params)
        redirect_to root_url
      else
        render 'edit'
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :language)
    end
  end
end
