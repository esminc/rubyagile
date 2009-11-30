class KarekiEntriesController < ApplicationController
  before_filter :login_required

  def index
    @entries = KarekiEntry.all
  end
end
