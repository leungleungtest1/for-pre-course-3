Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "video#index"
  root "video#index"
  resources :video
  resources :category
end
