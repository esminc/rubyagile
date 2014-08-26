RubyAgile::Application.routes.draw do

  root :to => 'welcome#index'
  get '/dashboard' => 'dashboard#index', :as => :dashboard

  get '/auth/:provider/callback' => 'authentications#create'
  get '/signin' => 'authentications#new', :as => :signin
  delete '/signout' => 'authentications#signout', :as => :signout

  resources :authentications

  resources :nakanohitos
  resources :pages
  resources :articles, constraints: {id: /\d{1,11}/} do
    collection do
      get :feed
    end
  end

  resources :kareki_entries do
    collection do
      post :crawl
    end
  end

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  match '/:controller(/:action(/:id))', via: [:get, :post]
end
