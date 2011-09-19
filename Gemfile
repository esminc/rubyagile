source :rubygems

gem 'rails'
gem 'rake', '~> 0.8.7', require: false

gem 'haml-rails'
gem 'jquery-rails'

gem 'omniauth', '~> 0.2.6'
gem 'rails_admin', git: 'git://github.com/sferik/rails_admin.git'

gem 'kaminari'
gem 'nokogiri'
gem 'feedzirra'
gem 'disqus'
gem 'gravtastic'
gem 'dynamic_form'
gem 'hikidoc'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  gem 'sqlite3'
  gem 'thin'
  gem 'heroku_san'
  gem 'traceroute'
end

group :test do
  gem 'pg'
  gem 'fabrication'
  gem 'forgery', '0.3.10'
  gem 'capybara'
  gem 'fuubar'
end

group :development, :test do
  gem 'mustang' # travis-ci
  gem 'rspec-rails'
  gem 'tapp'
end

group :production do
  gem 'pg'
  gem 'exception_notification'
  gem 'therubyracer-heroku'
end
