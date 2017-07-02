Rails.application.routes.draw do

  devise_for :users
  resources :wikis

  root to: 'home#index'

end
