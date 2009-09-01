class KarekiEntry < ActiveRecord::Base
  belongs_to :feed

  class << self
    def from_item(item)
      # TODO impl
      raise NotImplementedError
    end
  end
end
