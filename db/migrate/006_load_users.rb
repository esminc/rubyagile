require 'active_record/fixtures'
class LoadUsers < ActiveRecord::Migration
  def self.up
    ActiveRecord::Fixtures.create_fixtures(File.dirname(__FILE__), File.basename("users.yml", ".*"))
  end

  def self.down
    users = YAML.load_file("#{File.dirname(__FILE__)}/users.yml")
    User.destroy(users.map{ |_, attr| attr["id"]}) rescue nil
  end
end
