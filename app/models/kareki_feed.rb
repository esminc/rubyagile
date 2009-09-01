require 'rss'
require 'open-uri'

class KarekiFeed < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  has_many :kareki_entries

  class << self
    def crawl
#      KarekiFeed.all.each {|feed| fetch_entries(feed.url}
    end
  end

  # XXX call for better method name :<
  def fetch_and_save_entries
    # self.urlからKarekiEntryをつくる
  end

  def exist?
    !!feed_content.present?
  end

  def before_save
    feed = RSS::Parser.parse(open(url).read)
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
end
