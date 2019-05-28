Rails.application.routes.draw do
  get 'users/index'
  get 'users/new'
  get 'users/create'
  devise_for :doctors
  devise_for :users
  root to: 'pages#home'
  resources :doctors, only: [:index, :show]
  resources :appointments, only: [:index, :update]
end
