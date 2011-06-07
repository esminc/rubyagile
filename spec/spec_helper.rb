ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

require 'rspec/rails'
require 'capybara/rails'

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:twitter, {:uid => '12345'})

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.global_fixtures = :users
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.before :all do
    Sham.reset :before_all
  end

  config.before :each do
    Sham.reset :before_each
  end
end
