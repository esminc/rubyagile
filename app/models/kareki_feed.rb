class KarekiFeed < ActiveRecord::Base
  has_many :entries, :dependent => :destroy, :foreign_key => :feed_id, :class_name => KarekiEntry.to_s
  belongs_to :owner, :class_name => User.to_s
  validates_uniqueness_of :url

  class << self
    def crawl
      KarekiFeed.all.each {|feed| feed.fetch_and_save_entries }
    end
  end

  # XXX call for better method name :<
  def fetch_and_save_entries
    create_entries_from(parse_feed_content)
  ensure
    # XXX handle exception someway?
  end

  def before_save
    feed = parse_feed_content
    self.title = feed.title
    self.link = feed.url
  end

  private

  def parse_feed_content
    Feedzirra::Feed.fetch_and_parse(url)
  end

  def create_entries_from(feed)
    feed.entries.each do |entry|
      e = KarekiEntry.build_from_entry(entry)
      e.feed_id = self.id
      e.save
    end
  end
end
