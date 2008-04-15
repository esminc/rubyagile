class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :name
      t.text :content
      t.references :user

      t.timestamps
    end

    add_index(:pages, :name, :unique => true)
  end

  def self.down
    drop_table :pages
  end
end
