class KarekiEntry < ActiveRecord::Base
  RSS_ITEM_TO_KAREKI_ENTRY = {
    :title => :title,
    :description => :content,
    :link => :link,
    :date => :published_at,
    :dc_creator => :creator
  }.freeze

  belongs_to :feed

  class << self
    def create_from_item(item)
      param = RSS_ITEM_TO_KAREKI_ENTRY.inject({}){|h,(k,v)|
        h.update(v => item.send(k))
      }
      new(param)
    end
  end
end
