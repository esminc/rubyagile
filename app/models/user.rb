class User < ActiveRecord::Base
  has_many :articles
  has_many :pages
  has_many :feeds, :class_name => KarekiFeed.name, :foreign_key => :owner_id

  validates_presence_of :login, :email, :open_id_url

  def to_param
     login
  end
end
