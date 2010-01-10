class KarekiEntry < ActiveRecord::Base
  RSS_ITEM_TO_KAREKI_ENTRY = {
    :title => :title,
    [:content, :summary] => :content,
    :url => :link,
    :published => :published_at,
    :author => :creator
  }.freeze

  belongs_to :feed, :foreign_key => :feed_id, :class_name => KarekiFeed.to_s

  named_scope :confirmed, :conditions => {:confirmation => "confirmed"}
  named_scope :newer_first, :order => %Q(#{quoted_table_name}.published_at DESC)

  class << self
    def build_from_entry(entry)
      attributes = adapt_param(entry)
      returning(find_or_initialize_by_link(attributes[:link])) do |entry|
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
end
