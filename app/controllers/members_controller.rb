class MembersController < ApplicationController
  def index
    @members = User.all(:conditions => {:member => true})
  end

  def show
    @member = User.find_by_login!(params[:id])
  end
end
