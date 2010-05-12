class MembersController < ApplicationController
  def show
    @member = User.find_by_login(params[:id])
  end
end
