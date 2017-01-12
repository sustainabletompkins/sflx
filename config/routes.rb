Rails.application.routes.draw do

  root 'pages#home'

  resources :listings

  get '/admin' => 'pages#admin'

  get '/category/:id' => 'categories#show', :as => :load_category
  get '/list/:id' => 'lists#show', :as => :load_list

end
