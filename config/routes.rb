Rails.application.routes.draw do
  devise_for :doctors
  devise_for :users
  root to: 'pages#home'
  resources :doctors, only: [:index, :show]
  resources :appointments, only: [:index, :update]
end
