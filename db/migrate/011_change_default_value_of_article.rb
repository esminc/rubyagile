class ChangeDefaultValueOfArticle < ActiveRecord::Migration
  def self.up
    change_column(:articles, :title, :string, :default => "", :null => false)
    change_column(:articles, :body, :text, :default => "", :null => false)
  end

  def self.down
    change_column(:articles, :title, :string)
    change_column(:articles, :body, :text)
  end
end
