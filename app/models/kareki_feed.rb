require 'rss'
require 'open-uri'

class KarekiFeed < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :entries, {:foreign_key => :feed_id, :class_name => KarekiEntry.to_s }

  class << self
    def crawl
      KarekiFeed.all.each {|feed| feed.fetch_and_save_entries }
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
      entry = KarekiEntry.build_from_item(item)
      entry.feed_id = self.id
      entry.save
    end
  end
end
