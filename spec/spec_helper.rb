require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  require 'rspec/rails'

  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}
  RSpec.configure do |config|
    config.include WardenHelperMethods

    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.global_fixtures = :users
    config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

    config.mock_with :rr

    config.before :all do
      Sham.reset :before_all
    end

    config.before :each do
      Sham.reset :before_each
    end
  end
end
