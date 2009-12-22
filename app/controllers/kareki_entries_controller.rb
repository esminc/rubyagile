class KarekiEntriesController < ApplicationController
  before_filter :login_required

  def index
    @entries = KarekiEntry.all
  end

  def update
    @entry = KarekiEntry.find(params[:id])
    @entry.update_attributes(params[:kareki_entry])

    redirect_to :action => :index
  end
end
