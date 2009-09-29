class KarekiEntry < ActiveRecord::Base
  RSS_ITEM_TO_KAREKI_ENTRY = {
    :title => :title,
    [:content_encoded, :description] => :content,
    :link => :link,
    :date => :published_at,
    :dc_creator => :creator
  }.freeze

  belongs_to :feed

  class << self
    def build_from_item(item)
      param = RSS_ITEM_TO_KAREKI_ENTRY.each_with_object({}) {|(ks,v), h|
        h[v] = Array(ks).map{|k| item.send(k) }.compact.first
      }
      # remove singleton method Time#now from RSS::Parser
      new(param.update(:published_at => param[:published_at].to_datetime))
    end
  end
end
