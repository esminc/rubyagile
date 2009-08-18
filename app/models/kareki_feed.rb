require 'rss'
require 'open-uri'

class KarekiFeed < ActiveRecord::Base
  extend ActiveSupport::Memoizable

  def exist?
    begin
      feed_content.present?
    rescue OpenURI::HTTPError => why
      false
    end
  end

  private
  def before_save
    feed = RSS::Parser.parse(open(url).read)
    self.title = feed.channel.title
    self.link = feed.channel.link
  end

  def feed_content
    begin
      open(url).read
    rescue OpenURI::HTTPError
      nil
    end
  end
  memoize :feed_content
end
