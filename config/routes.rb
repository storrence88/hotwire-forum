# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :discussions, only: :index
  root 'main#index'
end
