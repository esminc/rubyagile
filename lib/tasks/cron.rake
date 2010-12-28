task :cron => :environment do
  KarekiFeed.crawl
end
