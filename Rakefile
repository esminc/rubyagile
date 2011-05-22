# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

if defined? Rake::DSL
  class RubyAgile::Application
    include Rake::DSL
  end

  class Rails::Railtie
    extend Rake::DSL
  end
end

RubyAgile::Application.load_tasks
