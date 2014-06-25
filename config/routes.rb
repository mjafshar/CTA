Rails.application.routes.draw do
  resources :routes
  resources :stops
  get '/search' => 'stops#search'

  root :to => 'index#index'
end
