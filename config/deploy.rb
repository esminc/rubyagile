set :application, "rubyagile"
print "projects.tky.esm.co.jp account: "
set :git_username do
  Capistrano::CLI.prompt("ssh account name :")
end
set :repository,  "ssh://#{git_username}@projects.tky.esm.co.jp/var/cache/git/rubyagile"
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

set :production_server, "agile.esm.co.jp"
role :app, production_server
role :web, production_server
role :db,  production_server, :primary => true

set :rake, "/var/lib/gems/1.8/bin/rake"

namespace :deploy do
  desc "make .mo file"
  task :makemo do
    rake = fetch(:rake, "rake")
    rails_env = fetch(:rails_env, "production")
    run "cd #{latest_release}; #{rake} RAILS_ENV=#{rails_env} gettext:make:mo"
  end

  task :after_update_code do
    src_db_yml = "#{shared_path}/config/database.yml"
    dest_db_yml = "#{latest_release}/config/database.yml"
    run "! test -e #{dest_db_yml} && ln -s #{src_db_yml} #{dest_db_yml}"
#    makemo
  end

  desc "resart for our retrospectiva"
  task :restart, :roles => :app, :except => { :no_release => true } do |t|
    stop
    start
  end
end
