Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "registrations" }

  root 'pages#home'

  resources :listings do
    member do
      get 'approve'
    end
  end

  resources :lists, :only=>[:destroy] do
    member do
      get 'approve'
    end
  end

  resources :users, :only=>[:destroy, :edit, :index]

  get '/admin' => 'pages#admin'
  get '/list' => 'pages#list'
  get '/map/:category' => 'pages#map', :as => :map
  get '/category/:id' => 'categories#show', :as => :load_category
  get '/list/:id' => 'lists#show', :as => :load_list
  get '/list/:id/tags/:tag' => 'lists#tagged', :as => :load_list_by_tag
  get '/autocomplete/tags' => 'listings#autocomplete_tags'
  get '/search/:q' => 'listings#search'
  post '/map/search/' => 'pages#map', :as => :map_search

  get '/tags/create' => 'tags#create', :as => :create_tag
  get '/lists/create' => 'lists#create', :as => :create_list
  delete '/tags/:id/delete' => 'tags#destroy', :as => :tag
  get '/tags/:id/approve-new' => 'tags#approve', :as => :approve_new_tag
  get '/tags/suggest-existing' => 'tags#suggest_existing', :as => :suggest_existing_tag
  get '/tags/:id/approve-existing' => 'tags#approve_existing', :as => :approve_existing_tag

  delete '/tags/:id/delete-suggestion' => 'tags#destroy_existing', :as => :tag_suggestion
end
