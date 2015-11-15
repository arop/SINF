Rails.application.routes.draw do
  resources :profiles
  
  root 'home#index'

  get 'home/index'
  get 'categoria/:id' => 'categoria#index', :id => /.*/
  get 'product/:id' => 'product#show', :id => /.*/
  get 'client' => 'profiles#show'


devise_for :users, :controllers => { registrations: 'registration' }

end
