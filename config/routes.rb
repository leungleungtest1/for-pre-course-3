Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "videos#index"
  root to: "pages#front"
  resources :videos do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :category
  get '/register', to: "users#new"
  resources :users
  get '/sign_in', to:"sessions#new"
  resources :sessions, only:[:create]
  get '/sign_out', to:"sessions#destroy"
  resources :reviews, only:[:create]
  get '/my_queue', to: "queue_items#index"
  resources :queue_items, only: [:create,:destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  get 'forgot_password', to: 'forgot_passwords#new'
  resources :peoples
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :password_resets, only:[:show,:create]
  get "expired_token", to: "password_resets#expired_token"
  get "invite_friends", to: "invitation#invite_friends"
  post "invite_friend", to: "invitation#send_invitation"
end

