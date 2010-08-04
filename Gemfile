source :rubygems

gem 'rails', '2.3.8', :require => nil
gem 'haml'
gem 'will_paginate'
gem 'nokogiri'
gem 'feedzirra'
gem 'disqus'
gem 'rack-openid', :require => 'rack/openid'
gem 'hoptoad_notifier'
gem 'gravtastic'

group :development do
  gem 'thin', :require => nil
  gem 'capistrano', :require => nil
  gem 'pit', :require => nil
end

group :test, :cucumber do
  gem 'rspec-rails'
  gem 'rr'
  gem 'machinist', :require => 'machinist/active_record'
  gem 'faker'
  gem 'autotest-rails'
  gem 'spork'
  gem 'diff-lcs'
end

group :production do
  gem 'mysql'
end
