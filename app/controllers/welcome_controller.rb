class WelcomeController < ApplicationController
  def index
    @articles = Article.publishing.includes(:user).limit(5)
    @entries  = KarekiEntry.confirmed.includes(:feed => :owner).page(params[:page])
  end
end
