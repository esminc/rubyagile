class Admin::Base < ApplicationController
  layout 'admin'
  before_filter :login_required
end
