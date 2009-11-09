class WelcomeController < ApplicationController
  def index
    @articles = Article.publishing.newer_first
    @entries = KarekiEntry.confirmed.newer_first

    respond_to do |format|
      format.html
    end
  end
end
