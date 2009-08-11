class CreateKarekiFeeds < ActiveRecord::Migration
  def self.up
    create_table :kareki_feeds do |t|
      t.string :title
      t.string :link
      t.string :url
      t.string :etag

      t.timestamps
    end
  end

  def self.down
    drop_table :kareki_feeds
  end
end
