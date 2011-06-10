class DropImages < ActiveRecord::Migration
  def up
    drop_table :images
    drop_table :db_files
  end

  def down
    create_table :images do |t|
      t.string :filename
      t.string :content_type
      t.integer :size
      t.integer :db_file_id
      t.integer :article_id

      t.timestamps
    end

    create_table :db_files do |t|
      t.binary :data, :null => false, :default => ''
    end
  end
end
