Rails.application.routes.draw do

  resources :charges, only: [:new, :create]
  resources :downgrade, only: [:new, :create]

  resources :wikis do
    resources :collaborators, only: [:index, :destroy, :create]
  end

  # Custom Routes
  # get 'cancel_charge' => 'charges#cancel'
  # get 'cancelling_charge' => 'charges#cancelling'

  devise_for :users

  root to: 'home#index'

end
