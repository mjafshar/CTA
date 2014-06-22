Rails.application.routes.draw do
  resources :routes
  resources :stops

  root :to => 'routes#index'
end
