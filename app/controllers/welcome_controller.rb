class WelcomeController < ApplicationController
  def index
    @articles = Article.publishing.limit(5)
    @entries = KarekiEntry.confirmed.page(params[:page])
  end
end
