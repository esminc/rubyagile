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
    def create_from_item(item)
      param = RSS_ITEM_TO_KAREKI_ENTRY.inject({}){|h,(ks,v)|
        h.update(v => Array(ks).map{|k| item.send(k) }.compact.first)
      }
      new(param)
    end
  end
end
