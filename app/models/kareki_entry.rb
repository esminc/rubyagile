class KarekiEntry < ActiveRecord::Base
  RSS_ITEM_TO_KAREKI_ENTRY = {
    :title => :title,
    [:content, :summary] => :content,
    :url => :link,
    :published => :published_at,
    :author => :creator
  }.freeze

  belongs_to :feed, :foreign_key => :feed_id, :class_name => KarekiFeed.to_s

  scope :confirmed, :conditions => {:confirmation => "confirmed"}
  scope :newer_first, :order => %Q(#{quoted_table_name}.published_at DESC)
  scope :recent, :order =>  %Q(#{quoted_table_name}.published_at DESC), :limit => 10

  class << self
    def build_from_entry(entry)
      attributes = adapt_param(entry)
      find_or_initialize_by_link(attributes[:link]).tap do |entry|
        entry.attributes = attributes
      end
    end

    private
    def adapt_param(entry)
      param = RSS_ITEM_TO_KAREKI_ENTRY.each_with_object({}) {|(ks,v), h|
        h[v] = Array(ks).map{|k| entry.send(k) }.compact.first
      }
    end
  end

  def confirmation
    ActiveSupport::StringInquirer.new( read_attribute("confirmation") )
  end

  def summary
    Nokogiri::XML.fragment(content).content.strip.gsub(/\s+/, ' ')
  end
end
