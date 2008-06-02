class RenamePublishedToArticles < ActiveRecord::Migration
  def self.up
    rename_column :articles, :published, :publishing
  end

  def self.down
    rename_column :articles, :publishing, :published
  end
end
