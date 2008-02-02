class Comment < ActiveRecord::Base
  def self.parse_params(params)
    spam_mark = !params.delete(:email).blank?
    comment = Comment.new(params)
    comment.spam = spam_mark
    comment
  end
  belongs_to :article
  validates_presence_of :author,:body,:ip_address
end
