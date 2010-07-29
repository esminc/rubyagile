namespace :ci do
  task :setup do
    user, pass = ENV.values_at('USER', 'PASS')

    open Rails.root.join('config', 'database.yml'), 'w' do |yml|
      yml.puts <<-YAML
test:
  adapter: mysql
  database: rubyagile_test
  encoding: utf8
  username: #{user}
  password: #{pass}
  socket: /var/run/mysqld/mysqld.sock
      YAML
    end
  end
end
