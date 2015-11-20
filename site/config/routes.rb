Rails.application.routes.draw do
  resources :profiles
  
  root 'home#index'

  get 'home/index'
  get 'categoria/:id' => 'categoria#index', :id => /.*/
  get 'product/:id' => 'product#show', :id => /.*/
  get 'client' => 'profiles#show'

  get 'carrinho' => 'cart_product#index'


devise_for :users, :controllers => { registrations: 'registration' }

end
