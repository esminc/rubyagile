class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :uid,      presence: true, uniqueness: {scope: :provider}
  validates :provider, presence: true

  def provider_name
    if self.provider == 'open_id'
      'OpenID'
    else
      self.provider.titleize
    end
  end
end
