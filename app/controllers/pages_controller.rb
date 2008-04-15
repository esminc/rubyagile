class PagesController < ApplicationController
  before_filter :login_required, :except => [:show, :index]

  def index
    respond_to do |format|
      format.html { show }
    end
  end

  def show
    @page = Page.find_by_name(params[:page_name])
    respond_to do |format|
      format.html
    end
  end

  def new
    @page = Page.new
    @page.user = current_user
    respond_to do |format|
      format.html
    end
  end

  def edit
    @page = Page.find_by_name(params[:page_name])
  end

  def update
    @page = Page.find_by_name(params[:page_name])
    @page.user = current_user
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
