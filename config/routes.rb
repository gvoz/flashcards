Rails.application.routes.draw do
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  get 'home/about'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "logout" => "user_sessions#destroy", :as => "logout"
  get "login" => "user_sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  post "check" => "cards#checktranslate", :as => "check"

  resources :users
  resources :user_sessions
  resources :decks do
    resources :cards
  end

  root 'home#index'
end
