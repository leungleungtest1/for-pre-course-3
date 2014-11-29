Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "videos#index"
  root to: "pages#front"
  resources :videos do
    collection do
      post 'search', to: 'videos#search'
    end
  end
  resources :category
  get '/register', to: "users#new"
  resources :users
  get '/sign_in', to:"sessions#new"
  resources :sessions, only:[:create]
  get '/sign_out', to:"sessions#destroy"
end
