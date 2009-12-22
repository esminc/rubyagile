class CreateKarekiEntries < ActiveRecord::Migration
  def self.up
    create_table :kareki_entries do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :link, :null => false
      t.boolean :confirmed, :null => false, :default => false
      t.timestamp :published_at, :null => false
      t.string :creator, :null => false
      t.references :feed, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :kareki_entries
  end
end
