class DropComments < ActiveRecord::Migration
  def self.up
    drop_table :comments
  end

  def self.down
    create_table :comments do |t|
      t.references :article
      t.string :author
      t.string :body
      t.string :ip_address
      t.timestamps
    end
  end
end
