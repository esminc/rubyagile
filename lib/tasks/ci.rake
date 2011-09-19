namespace :ci do
  task :setup do
    open File.expand_path('../../../config/database.yml', __FILE__), 'w' do |f|
      f.puts <<-EOF
test:
  adapter: postgresql
  username: postgres
  database: rubyagile_test
  encoding: unicode
      EOF
    end
  end
end
