Rails.application.routes.draw do

  root 'pages#home'

  resources :listings

  get '/admin' => 'pages#admin'
  get '/list' => 'pages#list'
  get '/map/:category' => 'pages#map', :as => :map
  get '/category/:id' => 'categories#show', :as => :load_category
  get '/list/:id' => 'lists#show', :as => :load_list
  get '/list/:id/tags/:tag' => 'lists#tagged', :as => :load_list_by_tag
  get '/autocomplete/tags' => 'listings#autocomplete_tags'
  get '/search/:q' => 'listings#search'
end
