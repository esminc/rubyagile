class KarekiEntriesController < ApplicationController
  before_filter :login_required

  def index
    @entries = KarekiEntry.all(:order => 'created_at DESC')
  end

  def update
    @entry = KarekiEntry.find(params[:id])
    @entry.update_attributes(params[:kareki_entry])

    redirect_to :action => :index
  end

  def crawl
    KarekiFeed.crawl
    redirect_to kareki_entries_path
  end
end
