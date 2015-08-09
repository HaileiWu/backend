Rails.application.routes.draw do

  devise_for :admins, controllers: {sessions: "admins/sessions"}

  root 'products#index'

  resources :products

  resources :users

  resources :user_products


end
