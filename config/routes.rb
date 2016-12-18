Rails.application.routes.draw do

  root 'pages#home'

  resources :listings

  get '/admin' => 'pages#admin'

end
