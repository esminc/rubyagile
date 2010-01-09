class KarekiFeedsController < ApplicationController
  before_filter :login_required

  # GET /kareki_feeds
  # GET /kareki_feeds.xml
  def index
    @kareki_feeds = KarekiFeed.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @kareki_feeds }
    end
  end

  # GET /kareki_feeds/1
  # GET /kareki_feeds/1.xml
  def show
    @kareki_feed = KarekiFeed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @kareki_feed }
    end
  end

  # GET /kareki_feeds/new
  # GET /kareki_feeds/new.xml
  def new
    @kareki_feed = KarekiFeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @kareki_feed }
    end
  end

  # GET /kareki_feeds/1/edit
  def edit
    @kareki_feed = KarekiFeed.find(params[:id])
  end

  # POST /kareki_feeds
  # POST /kareki_feeds.xml
  def create
    @kareki_feed = KarekiFeed.new(params[:kareki_feed])

    respond_to do |format|
      if @kareki_feed.save
        @kareki_feed.fetch_and_save_entries
        flash[:notice] = 'KarekiFeed was successfully created.'
        format.html { redirect_to(@kareki_feed) }
        format.xml  { render :xml => @kareki_feed, :status => :created, :location => @kareki_feed }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @kareki_feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /kareki_feeds/1
  # PUT /kareki_feeds/1.xml
  def update
    @kareki_feed = KarekiFeed.find(params[:id])

    respond_to do |format|
      if @kareki_feed.update_attributes(params[:kareki_feed])
        flash[:notice] = 'KarekiFeed was successfully updated.'
        format.html { redirect_to(@kareki_feed) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @kareki_feed.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /kareki_feeds/1
  # DELETE /kareki_feeds/1.xml
  def destroy
    @kareki_feed = KarekiFeed.find(params[:id])
    @kareki_feed.destroy

    respond_to do |format|
      format.html { redirect_to(kareki_feeds_url) }
      format.xml  { head :ok }
    end
  end
end
