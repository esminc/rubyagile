class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.string :email, :ip_address
      t.text :message
      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
