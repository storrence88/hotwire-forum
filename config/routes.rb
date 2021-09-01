# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :categories
  resources :discussions do
    resources :posts, module: :discussions
  end
  root 'main#index'
end
