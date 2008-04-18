class SearchController < ApplicationController
  def index
    @q = params[:q]
    @articles = @q.blank? ? Article.find(:all) : Article.find_fulltext(@q)
    @pages = @q.blank? ? Page.find(:all) : Page.find_fulltext(@q)
  end
end
