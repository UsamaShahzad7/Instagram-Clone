# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :accounts, controllers: {
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
    registrations: 'accounts/registrations',
    confirmations: 'accounts/confirmations'

  }
  namespace :admins do
    get '/', to: 'admins#index'
    get 'status', to: 'admins#status'
    post 'de_activate/:account_id', to: 'admins#de_activate', as: :admins_de_activate
    post 'activate/:account_id', to: 'admins#activate', as: :admins_activate
  end

  get 'accounts/confirmation_pending', to: 'profiles#after_registration_path'
  get 'accounts/after_confirmation', to: 'profiles#after_confirmation_path'
  post 'profiles/search', to: 'profiles#search'
  get 'profiles/status', to: 'profiles#change_status'
  root to: 'homes#index'
  resources :profiles, only: %i[new create index edit show update] do
    member do
      get '/friendships/follow', to: 'friendships#follow'
      get 'friendships/unfollow', to: 'friendships#unfollow'
    end
  end
  get '/archives', to: "posts#archives"
  resources :posts, only: %i[new create edit update] do
    member do
      post '/share', to: 'posts#share'
      get '/archive_post', to: 'posts#archive_post'
      get '/un_archive_post', to: 'posts#un_archive_post'
      post '/likes/un_like', to: 'likes#un_like'
      post 'likes/like', to: 'likes#like'
    end
    resources :comments, :likes, shallow: true
  end
  delete '/posts/destroy', to: 'posts#destroy'
end
