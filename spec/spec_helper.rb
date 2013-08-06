ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'rspec/rails'
require 'capybara/rails'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
end
