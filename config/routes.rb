RubyAgile::Application.routes.draw do
  resources :nakanohitos
  resources :articles do
    collection do
      get :feed
    end
  end

  resources :pages do
    collection do
      get :feed
    end
  end

  resources :kareki_feeds
  resources :kareki_entries do
    collection do
      post :crawl
    end
  end

  resources :images
  resource :session
  namespace :admin do
    resources :users
  end

  match '/signin' => 'sessions#new', :as => :signin
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/dashboard' => 'dashboard#index', :as => :dashboard
  match '/:controller(/:action(/:id))'
  root :to => 'welcome#index'
end
