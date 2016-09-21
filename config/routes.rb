Rails.application.routes.draw do

  scope module: 'home' do
    post "oauth/callback" => "oauths#callback"
    get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
    get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
    resources :user_sessions
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    post "logout" => "user_sessions#destroy", :as => "logout"
    get "login" => "user_sessions#new", :as => "login"
    get 'about' => 'home#about'
    root 'home#index'
  end

  scope module: 'dashboard' do
    post "check" => "cards#checktranslate", :as => "check"
    get "signup" => "users#new", :as => "signup"

    resources :users
    resources :decks do
      resources :cards
    end
  end
end
