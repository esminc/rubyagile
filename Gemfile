source :rubygems

gem 'rails'
gem 'haml-rails'
gem 'sass'
gem 'jquery-rails'

gem 'nokogiri'
gem 'feedzirra'
gem 'disqus'
gem 'gravtastic'
gem 'rails_warden'
gem 'warden-openid'
gem 'dynamic_form'
gem 'verification'
gem 'hikidoc'
gem 'hassle', :git => 'git://github.com/koppen/hassle.git'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'

group :development do
  gem 'passenger'
  gem 'heroku_san'
  gem 'taps'
  gem 'traceroute'
end

group :test do
  gem 'machinist', :require => 'machinist/active_record'
  gem 'forgery'
  gem 'fuubar'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
  gem 'tapp'
end

group :production do
  gem 'pg'
end
