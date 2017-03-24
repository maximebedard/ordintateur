require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users

  root 'yolo#index'

  mount Sidekiq::Web => '/sidekiq'
end
