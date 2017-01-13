Rails.application.routes.draw do

  root 'pages#home'

  resources :listings

  get '/admin' => 'pages#admin'

  get '/category/:id' => 'categories#show', :as => :load_category
  get '/list/:id' => 'lists#show', :as => :load_list
  get '/list/:id/tags/:tag' => 'lists#tagged', :as => :load_list_by_tag

end
