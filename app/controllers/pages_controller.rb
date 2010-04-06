class PagesController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :feed]

  def index
    redirect_to page_path('FrontPage')
  end

  def show
    @page = Page.find_by_name!(params[:id])

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
    @page = Page.new
    create_or_update
  end

  def edit
    @page = Page.find_by_name!(params[:id])
  end

  def update
    @page = Page.find_by_name!(params[:id])
    create_or_update
  end

  def feed
    @pages = Page.find(:all, :order => "updated_at DESC")
    respond_to do |format|
      format.xml { render :layout => nil }
      format.rdf { render :layout => nil }
    end
  end

  private

  def create_or_update
    new = @page.new_record?
    @page.attributes = params[:page].merge(:user => current_user)

    if params[:preview].present?
      render :preview
    else
      if @page.save
        flash[:notice] = "Page was successfully #{new ? 'created' : 'updated'}."
        redirect_to @page
      else
        render new ? :new : :edit
      end
    end
  end
end
