Rails.application.routes.draw do

  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post "logout" => "user_sessions#destroy", :as => "logout"
  get "login" => "user_sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  resources :users
  resources :user_sessions
  resources :cards do
    get :checktranslate, on: :member
  end

  root 'home#index'
end
