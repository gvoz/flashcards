# ApplicationController for dashboard namespace
class Dashboard::ApplicationController < ApplicationController

  private

  def not_authenticated
    flash[:error] = "Войдите для доступа"
    redirect_to login_url
  end
end
