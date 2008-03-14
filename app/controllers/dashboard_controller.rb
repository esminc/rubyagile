class DashboardController < ApplicationController
  before_filter :login_required

  def index
    @articles = Article.find_all_written_by(current_user)
  end
end
