set :application, "rubyagile"
set :repository,  "https://projects.tky.esm.co.jp/svn/rubyagile/trunk/"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/#{application}/railsapp"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :use_sudo, false
set :runner, "rubyagile"
ssh_options[:username] = application

set :production_server, "agile.esm.co.jp"
role :app, production_server
role :web, production_server
role :db,  production_server, :primary => true

set :rake, "/var/lib/gems/1.8/bin/rake"

#default_environment["PATH"] = "/var/lib/gems/1.8/bin:/usr/local/bin:/usr/bin:/bin:/usr/bin/X11:/usr/games"

#task :after_update_code do
#  shared_db_yml = "#{shared_path}/config/database.yml"
#  dest_db_yml = "#{current_release}/config/database.yml"
#  run "! test -e #{dest_db_yml} && cp #{shared_db_yml} #{dest_db_yml}"
#end

namespace :deploy do
  task :after_update_code do
    src_db_yml = "#{shared_path}/config/database.yml"
    dest_db_yml = "#{release_path}/config/database.yml"
    run "! test -e #{dest_db_yml} && ln -s #{src_db_yml} #{dest_db_yml}"
  end
end
