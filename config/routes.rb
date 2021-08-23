# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :discussions do
    resources :posts, only: :create, module: :discussions
  end
  root 'main#index'
end
