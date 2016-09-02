class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

    def not_authenticated
      flash[:error] = "Войдите для доступа"
      redirect_to login_url
    end
end
