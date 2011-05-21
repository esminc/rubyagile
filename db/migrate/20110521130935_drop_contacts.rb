class DropContacts < ActiveRecord::Migration
  def self.up
    drop_table :contacts
  end

  def self.down
    create_table :contacts do |t|
      t.string :email, :ip_address
      t.text :message
      t.timestamps
    end
  end
end
