# Oauths controller
class OauthsController < ApplicationController
  # skip_before_filter :require_login

  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if current_user
      if @user = add_provider_to_user(provider)
        redirect_to root_path, success: 'Вы подключили #{provider.titleize}'
      end
    elsif @user = login_from(provider)
      redirect_to root_path, :notice => "Вы вошли через #{provider.titleize}!"
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, :notice => "Вы вошли через #{provider.titleize}!"
      rescue
        redirect_to home_about_path, :error => "Ошибка входа через #{provider.titleize}!"
      end
    end
  end
end
