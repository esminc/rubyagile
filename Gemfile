source :rubygems

gem 'rails', '~> 3.0.0'
gem 'haml-rails'

gem 'will_paginate', '~> 3.0.pre'
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
  gem 'heroku', :require => nil
  gem 'taps', :require => nil
end

group :test do
  gem 'machinist', :require => 'machinist/active_record'
  gem 'forgery'
  gem 'spork', '~> 0.9.0.rc2'
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
