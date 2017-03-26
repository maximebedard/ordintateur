require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users

  root 'yolo#index'

  resources :videos do
    resources :comments, only: [:create]
  end

  mount Sidekiq::Web => '/sidekiq'
end
