class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :authentications
  has_many :articles
  has_many :pages
  has_many :feeds, :class_name => KarekiFeed.name, :foreign_key => :owner_id
  has_many :entries, :class_name => KarekiEntry.name, :through => :feeds

  validates_presence_of :login, :email

  def to_param
    login
  end

  def accepted_rate
    all = KarekiEntry.confirmed.count

    return 0.0 if all.zero?

    mine = entries.confirmed.count
    mine.to_f / all * 100
  end
end
