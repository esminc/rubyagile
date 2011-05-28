class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :uid, uniqueness:true, presence:true
  validates :provider, presence:true
end
