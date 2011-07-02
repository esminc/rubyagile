source :rubygems

gem 'rails', '~> 3.1.0.rc'
gem 'rake', '~> 0.8.7', require: false
gem 'haml-rails'
gem 'jquery-rails'
gem 'sass-rails', "~> 3.1.0.rc"
gem 'coffee-script'
gem 'uglifier'

gem 'omniauth', '~> 0.2.6'
gem 'kaminari'
gem 'nokogiri'
gem 'feedzirra'
gem 'disqus'
gem 'gravtastic'
gem 'dynamic_form'
gem 'hikidoc'
gem 'rails_admin', git: 'git://github.com/sferik/rails_admin.git', branch: 'rails-3.1'

group :development do
  gem 'thin'
  gem 'heroku_san'
  gem 'traceroute'
end

group :test do
  gem 'fabrication'
  gem 'forgery'
  gem 'capybara'
  gem 'fuubar'
end

group :development, :test do
  gem 'sqlite3'
  gem 'therubyracer'
  gem 'rspec-rails'
  gem 'tapp'
end

group :production do
  gem 'pg'
  gem 'exception_notification'
  gem 'therubyracer-heroku'
end
