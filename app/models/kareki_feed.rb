require 'rss'
require 'open-uri'

class KarekiFeed < ActiveRecord::Base
  def before_save
    feed = RSS::Parser.parse(open(url).read)
    self.title = feed.channel.title
    self.link = feed.channel.link
  end
end
