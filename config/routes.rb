RubyAgile::Application.routes.draw do

  root :to => 'welcome#index'
  match '/dashboard' => 'dashboard#index', :as => :dashboard, via: [:get, :post]

  match '/auth/:provider/callback' => 'authentications#create', via: [:get, :post]
  match '/signin' => 'authentications#new', :as => :signin, via: [:get, :post]
  match '/signout' => 'authentications#signout', :as => :signout, via: [:get, :post]

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
