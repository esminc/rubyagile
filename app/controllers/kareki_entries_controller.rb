class KarekiEntriesController < ApplicationController
  before_filter :login_required

  def index
    @entries = KarekiEntry.order('created_at DESC')
  end

  def update
    @entry = KarekiEntry.find(params[:id])
    @entry.update_attributes(
      params.require(
        :kareki_entry
      ).permit(
        :titile,
        :content,
        :link,
        :published_at,
        :creator,
        :feed_id,
        :confirmation,
      )
    )

    redirect_to :action => :index
  end

  def crawl
    KarekiFeed.crawl
    redirect_to kareki_entries_path
  end
end
