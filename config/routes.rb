ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'welcome'

  map.resources :kareki_feeds
  map.resources :kareki_entries, :collection => {:crawl => :post}
  map.resources :images
  map.resource :session

  map.with_options :collection => {:feed => :get} do |feed|
    feed.resources :articles
    feed.resources :pages
  end

  map.connect '/pages/:page_name/:action', :controller => 'pages'
  map.front_page '/pages', :controller => 'pages', :page_name => 'FrontPage', :action => 'show'

  map.signin '/signin', :controller => "sessions", :action => "new"
  map.signout '/signout', :controller => "sessions", :action => "destroy"
  map.dashboard '/dashboard', :controller => 'dashboard', :action => 'index'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
