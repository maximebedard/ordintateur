require 'sidekiq/web'
Rails.application.routes.draw do
  get 'profile/index'

  devise_for :users

  root 'yolo#index'

  resources :videos do
    post :like
    resources :comments, only: [:create]

  end

  get '/profile' => 'profile#index'
  get '/profile/edit' => 'profile#edit'
  post '/profile' => 'profile#update'

  get '/search' => 'videos#search'

  mount Sidekiq::Web => '/sidekiq'
end
