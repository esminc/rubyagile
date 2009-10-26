class KarekiEntry < ActiveRecord::Base
  RSS_ITEM_TO_KAREKI_ENTRY = {
    :title => :title,
    [:content_encoded, :description] => :content,
    :link => :link,
    :date => :published_at,
    :dc_creator => :creator
  }.freeze

  belongs_to :feed, {:foreign_key => :feed_id, :class_name => KarekiFeed.to_s}

  named_scope :confirmed, :conditions => {:confirmed => true}
  named_scope :newer_first, :order => 'published_at DESC'

  class << self
    def build_from_item(item)
      attributes = adapt_param(item)
      returning(find_or_initialize_by_link(attributes[:link])) do |entry|
        entry.attributes = attributes
      end
    end

    private
    def adapt_param(item)
      param = RSS_ITEM_TO_KAREKI_ENTRY.each_with_object({}) {|(ks,v), h|
        h[v] = Array(ks).map{|k| item.send(k) }.compact.first
      }
      # remove singleton method Time#now from RSS::Parser
      param.update(:published_at => param[:published_at].to_datetime)
    end
  end
end
