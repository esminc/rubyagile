class User < ActiveRecord::Base
  has_many :articles
  has_many :pages

  validates_presence_of :login, :email, :open_id_url
end
