class Admin::UsersController < Admin::Base
  admin_assistant_for User do |config|
    config.actions << :destroy
    config.index.sort_by :login
  end
end
