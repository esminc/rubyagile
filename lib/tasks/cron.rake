desc 'update Kareki feeds'
task :cron => :environment do
  KarekiFeed.crawl
end
