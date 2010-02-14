# -*- coding: utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :content
  validates_uniqueness_of :name

  acts_as_searchable :searchable_fields => [:name, :content]

  # models/article.rb とdupっている
  def author_name
    user.login
  end

  def to_param
    name
  end
end
