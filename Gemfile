source 'https://rubygems.org'

ruby '2.0.0'

gem 'disqus'
gem 'dynamic_form'
gem 'feedzirra'
gem 'gravtastic'
gem 'haml-rails'
gem 'hikidoc'
gem 'jquery-rails'
gem 'kaminari'
gem 'nokogiri'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-github'
gem 'omniauth-linkedin'
gem 'omniauth-openid'
gem 'omniauth-twitter'
gem 'pg'
gem 'rails', '~> 3.2.6'
gem 'rails_admin'#, git: 'git://github.com/sferik/rails_admin.git'
gem 'thin'

gem 'loofah', '1.2.1'

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
