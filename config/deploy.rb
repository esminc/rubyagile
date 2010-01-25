set :application, "rubyagile"
set :repository,  "git://github.com/esminc/rubyagile.git"
set :branch, "master"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{application}/railsapp"
set :ssh_options, { :forward_agent => true }

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :git_shallow_clone, 1

set :use_sudo, false
set :runner, "rubyagile"
ssh_options[:username] = application
#ssh_options[:verbose] = :debug

set :production_server, "ruby.agile.esm.co.jp"
role :app, production_server
role :web, production_server
role :db,  production_server, :primary => true

set :rake, "/var/lib/gems/1.8/bin/rake"

namespace :deploy do
  after 'deploy:finalize_update' do
    src_db_yml = "#{shared_path}/config/database.yml"
    dest_db_yml = "#{latest_release}/config/database.yml"
    run "! test -e #{dest_db_yml} && ln -s #{src_db_yml} #{dest_db_yml}"

    bundler_root = "#{latest_release}/vendor/bundler_gems/ruby/1.8"
    run "mkdir -p #{bundler_root} && ln -s #{shared_path}/gems #{bundler_root}/cache"
    run "cd #{latest_release} && gem bundle --only production"
  end

  %w(start stop).each do |t|
    task t, :roles => :app do
      # do nothing
    end
  end

  desc "Restart application."
  task :restart, :roles => :app, :except => { :no_release => true } do |t|
    run "touch #{current_release}/tmp/restart.txt"
  end
end
