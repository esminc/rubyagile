namespace :ci do
  task :setup => :environment do
    Rails.root.join('config', 'database.yml').open('w') do |f|
      f.puts <<-EOF
test:
  adapter: sqlite3
  database: db/test.sqlite3
      EOF
    end
  end
end
