class Page < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :content
  validates_uniqueness_of :name

  # models/article.rb とdupっている
  def author_name
    user.login
  end
end