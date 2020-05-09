Rails.application.routes.draw do
  
  get 'transactions/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'items#index'
  resources :items, only: [:index, :show]
end
