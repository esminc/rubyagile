class AddUserIdToKarekiFeed < ActiveRecord::Migration
  def self.up
    add_column :kareki_feeds, :user_id, :integer
  end

  def self.down
    remove_column :kareki_feeds, :user_id
  end
end
