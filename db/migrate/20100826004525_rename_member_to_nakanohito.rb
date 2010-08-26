class RenameMemberToNakanohito < ActiveRecord::Migration
  def self.up
    rename_column :users, :member, :nakanohito
  end

  def self.down
    rename_column :users, :nakanohito, :member
  end
end








