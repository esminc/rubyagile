class CreateForUserAuthentications < ActiveRecord::Migration
  def self.up
    User.all.each do |u|
      Authentication.create!(:uid => u.open_id_url, :provider => 'open_id', :user_id => u.id)
    end

    remove_column :users, :open_id_url
  end

  def self.down
    Authentication.delete_all
    add_column :users, :open_id_url, :string
  end
end
