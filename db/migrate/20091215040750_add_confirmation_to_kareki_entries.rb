class AddConfirmationToKarekiEntries < ActiveRecord::Migration
  def self.up
    add_column :kareki_entries, :confirmation, :string, :null => false, :limit => 16, :default => "not_yet"
    add_index  :kareki_entries, :confirmation
    KarekiEntry.update_all("confirmation='confirmed'", {:confirmed => true})
    remove_column :kareki_entries, :confirmed
  end

  def self.down
    add_column :kareki_entries, :confirmed, :boolean, :null => false, :default => false
    remove_index  :kareki_entries, :confirmation
    remove_column :kareki_entries, :confirmation
  end
end
