bundle_path 'vendor/bundler_gems'

clear_sources
source 'http://gemcutter.org'
source 'http://gems.github.com'

gem 'rails', '2.3.5'
gem 'haml'
gem 'will_paginate'
gem 'nokogiri'
gem 'feedzirra'
gem 'disqus'
gem 'ruby-openid', :require_as => 'openid'
gem 'moro-open_id_authentication', :require_as => 'open_id_authentication'

only :development do
  gem 'rails-footnotes'
end

only :test do
  gem 'rspec-rails'
  gem 'rr'
  gem 'autotest-rails'
  gem 'spork'
end

only :production do
  gem 'mysql'
end
