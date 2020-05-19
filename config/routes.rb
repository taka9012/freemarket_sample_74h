Rails.application.routes.draw do
  
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
  
  root 'items#index'
  resources :credit_cards, only: [:index]
  resources :items, only: [:index, :show, :new]
  resources :credit_registrations, only: [:index]
  
  resources :items do
    collection do
      get "set_images"
    end
  end

  resources :users, only: [:show] do
    resources :profiles, only: [:new, :edit, :create, :update]
  end
end
