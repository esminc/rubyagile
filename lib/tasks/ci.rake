namespace :ci do
  task :setup do
    open File.expand_path('../../../config/database.yml', __FILE__), 'w' do |f|
      f.puts <<-EOF
test:
  adapter: sqlite3
  database: db/test.sqlite3
      EOF
    end
  end
end
