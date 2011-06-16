RubyAgile::Application.routes.draw do

  root :to => 'welcome#index'
  match '/dashboard' => 'dashboard#index', :as => :dashboard

  match '/auth/:provider/callback' => 'authentications#create'
  match '/signin' => 'authentications#new', :as => :signin
  match '/signout' => 'authentications#signout', :as => :signout

  resources :authentications

  resources :nakanohitos
  resources :pages
  resources :articles do
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

  match '/:controller(/:action(/:id))'
end
