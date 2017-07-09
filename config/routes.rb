Rails.application.routes.draw do

  resources :charges, only: [:new, :create]

  resources :wikis

  devise_for :users


  resources :users, only: [] do
    member do
      get 'downgrade'
    end
  end

  root to: 'home#index'

end
