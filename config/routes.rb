Rails.application.routes.draw do
  devise_for :doctors
  devise_for :users
  root to: 'pages#home'
  get '/doctors/appointments', to: 'doctors/appointments#index'
  resources :doctors, only: [:index, :show] do
        resources :appointments, only: [:new, :create]
        resources :reviews, only: [:new, :create]
  end
  resources :appointments, only: [:index, :update]

end
