class WelcomeController < ApplicationController
  def index
    @articles = Article.publishing.newer_first
    @entries = KarekiEntry.confirmed.newer_first.paginate(:page => params[:page], :per_page => 10)

    respond_to do |format|
      format.html
    end
  end
end
