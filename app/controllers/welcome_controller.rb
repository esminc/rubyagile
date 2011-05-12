class WelcomeController < ApplicationController
  def index
    @articles = Article.publishing.newer_first.all(:limit => 5)
    @entries = KarekiEntry.confirmed.newer_first.page(params[:page])
  end
end
