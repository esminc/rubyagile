source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 3.2.6'
gem 'pg'

gem 'haml-rails'
gem 'jquery-rails'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-openid'
gem 'omniauth-twitter'
gem 'omniauth-linkedin'
gem 'omniauth-facebook'

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
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier'
end

group :development do
  gem 'foreman'
  gem 'heroku_san'

  group :test do
    gem 'rspec-rails'
    gem 'tapp'
  end
end

group :test do
  gem 'fabrication'
  gem 'forgery', '0.3.10'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'capybara'
  gem 'fuubar'
end

group :production do
  gem 'newrelic_rpm'
  gem 'exception_notification'
end
