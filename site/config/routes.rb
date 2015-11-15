Rails.application.routes.draw do
  devise_for :users
  resources :profiles
  
  root 'home#index'

  get 'home/index'
  get 'categoria/:id' => 'categoria#index', :id => /.*/
  get 'product/:id' => 'product#show', :id => /.*/
end
