class PagesController < ApplicationController
  before_filter :login_required, :except => [:index, :show, :feed]

  def index
    @page = Page.find_by_name!('FrontPage')
    render :show
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
    @page = Page.new(params[:page])

    unless params[:preview].blank?
      render :preview
    else
      respond_to do |format|
        if @page.save
          flash[:notice] = 'Page was successfully created.'
          format.html { redirect_to @page }
        else
          format.html { render :new }
        end
      end
    end
  end

  def edit
    @page = Page.find_by_name!(params[:id])
  end

  def update
    @page = Page.find_by_name!(params[:id])
    @page.user = current_user

    unless params[:preview].blank?
      @page.name = params[:page][:name]
      @page.content = params[:page][:content]
      render :preview
    else
      respond_to do |format|
        if @page.update_attributes(params[:page])
          flash[:notice] = 'Page was successfully updated.'
          format.html { redirect_to("/pages/#{params[:page][:name]}") }
        else
          format.html { render :edit }
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
end
