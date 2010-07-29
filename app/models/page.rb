# -*- coding: utf-8 -*-
class Page < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :content
  validates_uniqueness_of :name

  def to_param
    name
  end
end
