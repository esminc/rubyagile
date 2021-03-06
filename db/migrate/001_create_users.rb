class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :open_id_url
      t.string :fullname
      t.string :amazon_associate
      t.boolean :member

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
