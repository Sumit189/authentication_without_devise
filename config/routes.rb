Rails.application.routes.draw do
  root 'home#my_profile'
  get 'authenticate/signup'
  get 'authenticate/login'
  get 'password/forget_pass'
  get 'password/reset_password'
  post 'authenticate/signup'
  post 'authenticate/login'
  post 'password/forget_pass'
  post 'password/reset_password'
  get 'home/my_profile'
  post 'home/my_profile'
  resources :password, only: [:update]
  resources :home, only: [:update, :destroy]
  get 'home/logout' => 'home#logout'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
