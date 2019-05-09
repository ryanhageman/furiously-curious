# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  namespace :accounts do
    resources :profiles
    resources :post_images
  end

  namespace :blog_admin do
    resources :tags
    resources :categories
    resources :posts
    resources :drafts, only: %i[index update]
    resources :hidden_posts, only: %i[index update]
    resources :published_posts, only: %i[index update]
  end

  resources :articles, only: %i[index show]
  resources :categories, only: %i[index show]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
