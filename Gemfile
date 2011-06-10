source :rubygems

gem 'rails', '~> 3.1.0.rc2'
gem 'rake', '~> 0.8.7'
gem 'pg'
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'omniauth'
gem 'kaminari'
gem 'nokogiri'
gem 'feedzirra'
gem 'disqus'
gem 'gravtastic'
gem 'dynamic_form'
gem 'hikidoc'
gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git', :branch => 'rails-3.1'

group :development do
  gem 'thin'
  gem 'heroku_san', :git => 'git://github.com/esminc/heroku_san.git'
  gem 'traceroute'
end

group :test do
  gem 'machinist', :require => 'machinist/active_record'
  gem 'capybara'
  gem 'fuubar'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'forgery'
  gem 'tapp'
end

group :production do
  gem 'therubyracer-heroku'
end
