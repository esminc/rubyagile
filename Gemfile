source :rubygems

gem 'rails'
gem 'rake', '~> 0.8.7', require: false

gem 'pg'

gem 'haml-rails'
gem 'jquery-rails'

gem 'omniauth'
gem 'rails_admin', git: 'git://github.com/sferik/rails_admin.git'
gem 'unicorn'
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
  gem 'foreman'
  gem 'heroku_san'
  gem 'traceroute'
end

group :test do
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
  gem 'exception_notification'
end
