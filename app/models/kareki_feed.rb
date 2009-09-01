require 'rss'
require 'open-uri'

class KarekiFeed < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :kareki_entries

  class << self
    def crawl
# TODO write spec
#      KarekiFeed.all.each {|feed| fetch_entries(feed.url}
    end
  end

  # XXX call for better method name :<
  def fetch_and_save_entries
    feed = parse_feed_content
    create_entries_from(feed)
  ensure
    # XXX handle exception someway?
  end

  def exist?
    !!feed_content.present?
  end

  def before_save
    feed = parse_feed_content
    self.title = feed.channel.title
    self.link = feed.channel.link
  end

  private
  def feed_content
    open(url).read
  rescue OpenURI::HTTPError
    nil
  end
  memoize :feed_content

  def parse_feed_content
    RSS::Parser.parse(feed_content)
  end

  def create_entries_from(feed)
    feed.items.each do |item|
      KarekiEntry.create_from_item(item)
    end
  end
end
