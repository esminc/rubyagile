class WelcomeController < ApplicationController
  def index
    @articles = Article.publishing.all(:limit => 5)
    @entries = KarekiEntry.confirmed.page(params[:page])
  end
end
