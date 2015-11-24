Rails.application.routes.draw do
  resources :profiles

  resources :cart
  
  root 'home#index'

  get 'home/index'
  get 'categoria/:id' => 'categoria#index', :id => /.*/
  get 'product/:id' => 'product#show', :id => /.*/
  get 'client' => 'profiles#show'

  get 'carrinho' => 'cart#index'

  get 'carrinho/adicionar/:id_produto/:quantity' => 'cart_product#add', :id_produto => /.*/


devise_for :users, :controllers => { registrations: 'registration' }

end
