Rails.application.routes.draw do
  get 'image/new'

  get 'encomenda/new'

  get 'encomenda/show'

  resources :profiles

  resources :cart
  
  root 'home#index'

  get 'home/index'

  delete 'image/:id' => 'image#destroy'
  put 'image' => 'image#create'
  get 'image/id_produto/:id' => 'image#productImg', :id => /.*/

  delete 'product_description/:id' => 'product_description#destroy'
  put 'product_description' => 'product_description#create'

  get 'categoria/:id' => 'categoria#index', :id => /.*/

  get 'product/:id' => 'product#show', :id => /.*/
  get 'client' => 'profiles#show'

  get 'carrinho' => 'cart#index'
  post 'carrinho' => 'cart#send_cart_primavera'

#  get 'carrinho/adicionar/:id_produto/:quantity' => 'cart_product#add', :id_produto => /.*/
  post 'carrinho/adicionar' => 'cart#add_to_cart'
  
  get 'admins' => 'admin#index'

  get 'encomenda/:id' => 'encomenda#show', :id => /.*/

  devise_for :users, :controllers => { registrations: 'registration' }
       
end
