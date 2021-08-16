# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :discussions, only: %i[index new create]
  root 'main#index'
end
