class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :article
      t.string :body
      t.references :user
      t.string :name
      t.string :commenter_url
      t.string :ip_address

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
