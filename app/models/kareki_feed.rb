require 'rss'
require 'open-uri'

class KarekiFeed < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  def exist?
    !!feed_content.present?
  end

  private
  def before_save
    feed = RSS::Parser.parse(open(url).read)
    self.title = feed.channel.title
    self.link = feed.channel.link
  end

  def feed_content
    open(url).read
  rescue OpenURI::HTTPError
    nil
  end
  memoize :feed_content
end
