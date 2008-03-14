class AddPublishedToArticles < ActiveRecord::Migration
  def self.up
    add_column :articles, :published, :boolean, :default => false
    Article.find(:all).each { |article| article.update_attribute(:published, true) }
  end

  def self.down
    remove_column :articles, :published
  end
end
