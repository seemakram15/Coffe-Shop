# frozen_string_literal: true

Rails.application.routes.draw do
  # Routes in config/routes.rb
  resources :users do
    resources :orders, only: %i[new create index]
    resource :cart, only: %i[show create update destroy]
  end

  resources :categories, only: %i[new create]
  root 'home#index'
end
