# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'recent', to: 'pages#recent', as: 'recent'
  get 'about', to: 'pages#about', as: 'about'

  devise_scope :user do
    get 'admin', to: 'devise/sessions#new'
  end

  namespace :accounts do
    resources :post_images
    resources :profiles
  end

  namespace :blog_admin do
    get 'dashboard', to: 'dashboard#main', as: 'dashboard'
    resources :profiles
    resources :tags
    resources :categories
    resources :posts
    resources :drafts, only: %i[index update]
    resources :hidden_posts, only: %i[index update]
    resources :published_posts, only: %i[index update]
  end

  resources :articles, only: %i[index show]
  resources :categories, only: %i[index show]
  resources :tags, only: %i[index show]

  root 'pages#recent'
end
