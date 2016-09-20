# Oauths controller
module Home:
  class OauthsController < ApplicationController
    # skip_before_filter :require_login

    # sends the user on a trip to the provider,
    # and after authorizing there back to the callback url.
    def oauth
      login_at(provider)
    end

    def callback
      check_user_email
      if @user = login_from(provider)
        flash[:success] = t('.success', provider: provider.titleize)
        redirect_to root_path
      else
        create_user
      end
    end

    def create_user
      @user = create_from(provider)
      reset_session
      auto_login(@user)
      flash[:success] = t('.success', provider: provider.titleize)
      redirect_to root_path
    rescue
      flash[:error] = t('.error', provider: provider.titleize)
      redirect_to home_about_path
    end

    def check_user_email
      sorcery_fetch_user_hash provider
      if @user = User.find_by( email: @user_hash[:user_info]['email'])
        @user.add_provider_to_user(provider, @user_hash[:uid].to_s) unless Authentication.find_by(uid: @user_hash[:uid].to_s, user_id: @user.id)
      end
    end

    private

    def provider
      params.require(:provider)
    end
  end
end
