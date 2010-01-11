bundle_path 'vendor/bundler_gems'
source 'http://gemcutter.org'
source 'http://gems.github.com'

gem 'rails', '2.3.5'
gem 'haml'
gem 'will_paginate'
gem 'nokogiri'
gem 'pauldix-feedzirra', :require_as => 'feedzirra'
gem 'ruby-openid', :require_as => 'openid'
gem 'moro-open_id_authentication', :require_as => 'open_id_authentication'

only :development do
  gem 'rspec-rails'
  gem 'rr'
  gem 'rails-footnotes'
end

only :production do
  gem 'mysql'
end
