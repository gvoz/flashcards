# ApplicationController
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    locale =
      if current_user
        current_user.language
      else
        params[:locale] || http_accept_language.compatible_language_from(I18n.available_locales)
      end
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  private

  def not_authenticated
    flash[:error] = "Войдите для доступа"
    redirect_to login_url
  end
end
