# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :accounts do
    resources :profiles
    resources :post_images
  end
  namespace :blog_admin do
    resources :posts
    resources :drafts, only: [:index, :update]
    resources :hidden_posts, only: [:index, :update]
    resources :published_posts, only: [:index, :update]
  end

  resources :articles, only: [:index]
  resources :tags
  resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
