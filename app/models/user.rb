class User < ActiveRecord::Base
  validates_presence_of :login, :nickname, :email, :open_id_url
end
