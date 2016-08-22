Rails.application.routes.draw do
  get 'flash_cards/index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'flash_cards#index'
end
