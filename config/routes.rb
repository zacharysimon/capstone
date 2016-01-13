Rails.application.routes.draw do
  
  devise_for :users

  get '/' => 'listings#home'
  get '/listings' => 'listings#index'
  post '/listings' => 'listings#create'
  get '/listings/new' => 'listings#new'
  get '/listings/:id' => 'listings#show' 
  get '/listings/:id/edit' => 'listings#edit'
  patch '/listings/:id' => 'listings#update'
  delete '/listings/:id' => 'listings#destroy'

  get '/dashboards' => 'dashboards#index'
  get '/dashboards/edit' => 'dashboards#edit'
  patch '/dashboards/update' => 'dashboards#update'


  namespace :api do
    namespace :v1 do
      get '/listings' => 'listings#index'
      get '/dashboard' => 'listings#dashboard'
      patch '/dashboard' => 'listings#update'
    end
  end

  get '/assumptions' => 'assumptions#show' 
  get '/assumptions/edit' => 'assumptions#edit'
  patch '/assumptions' => 'assumptions#update'

  patch '/comments/:id' => 'comments#update'
  get '/comments/new' => 'comments#new'
  get '/comments/:id/edit' => 'comments#edit'
  post '/comments' => 'comments#create'
end
