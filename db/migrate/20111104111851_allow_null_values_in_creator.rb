class AllowNullValuesInCreator < ActiveRecord::Migration
  def up
    change_column_null :kareki_entries, :creator, true
  end

  def down
    change_column_null :kareki_entries, :creator, false
  end
end
