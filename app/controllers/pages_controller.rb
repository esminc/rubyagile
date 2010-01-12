class PagesController < ApplicationController
#  before_filter :authentication
  before_filter :login_required, :except => [:show, :feed, :search]

  def show
    @page = fetch_named_page(params[:page_name])
    respond_to do |format|
      format.html
    end
  end

  def new
    @page = Page.new
    @page.name = params[:page_name]
    @page.user = current_user
    respond_to do |format|
      format.html
    end
  end

  def create
    @page = Page.new(params[:page])
    unless params[:preview].blank?
      render :action => 'preview'
    else
      respond_to do |format|
        if @page.save
          flash[:notice] = 'Page was successfully created.'
          format.html { redirect_to("/pages/#{params[:page][:name]}") }
        else
          format.html { render :action => "new" }
        end
      end
    end
  end

  def edit
    @page = fetch_named_page(params[:page_name])
  end

  def update
    @page = fetch_named_page(params[:page_name])
    @page.user = current_user

    unless params[:preview].blank?
      @page.name = params[:page][:name]
      @page.content = params[:page][:content]
      render :action => 'preview'
    else
      respond_to do |format|
        if @page.update_attributes(params[:page])
          flash[:notice] = 'Page was successfully updated.'
          format.html { redirect_to("/pages/#{params[:page][:name]}") }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end

  def feed
    @pages = Page.find(:all, :order => "updated_at DESC")
    respond_to do |format|
      format.xml { render :layout => nil }
      format.rdf { render :layout => nil }
    end
  end

  private
  def find_or_create(page_name)
    unless page = Page.find_by_name(page_name)
      page = Page.new
      page.name = page_name
      page.user = current_user
    end
    page
  end

  def fetch_named_page(name)
    Page.find_by_name(name)
  end
end
