class User < ActiveRecord::Base
  validates_presence_of :login, :email, :open_id_url
end
