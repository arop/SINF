Rails.application.routes.draw do
  get 'image/new'

  get 'encomenda/new'

  get 'encomenda/show'

  resources :profiles

  resources :cart
  
  root 'home#index'

  get 'home/index'

  put 'image' => 'image#create'
  get 'image/id_produto/:id' => 'image#productImg', :id => /.*/

  get 'categoria/:id' => 'categoria#index', :id => /.*/
  get 'product/:id' => 'product#show', :id => /.*/
  get 'client' => 'profiles#show'

  get 'carrinho' => 'cart#index'

  get 'carrinho/adicionar/:id_produto/:quantity' => 'cart_product#add', :id_produto => /.*/

  get 'admins' => 'admin#index'

  get 'encomenda/:id' => 'encomenda#show', :id => /.*/

  devise_for :users, :controllers => { registrations: 'registration' }
       
end
