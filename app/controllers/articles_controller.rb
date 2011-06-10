class ArticlesController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :feed]

  def index
    @articles = Article.publishing.page(params[:page])
  end

  def show
    @article = accessible_articles.find(params[:id])
  end

  def new
    @article = Article.new
    @article.user = current_user
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article].merge(:publishing => params[:publish].present?))

    unless params[:article].blank?
      unless params[:preview].blank?
        render :action => 'preview'
      else
        respond_to do |format|
          if @article.save
            flash[:notice] = 'Article was successfully updated.'
            format.html { redirect_to(@article) }
          else
            format.html { render :action => "new" }
          end
        end
      end
    else
      redirect_to_edit_after_create_image
    end
  end

  def update
    @article = Article.find(params[:id])

    unless params[:article].blank?
      unless params[:preview].blank?
        @article.attributes = params[:article]
        render :action => 'preview'
      else
        respond_to do |format|
          if @article.update_attributes(params[:article].merge(:publishing => params[:publish].present?))
            flash[:notice] = 'Article was successfully updated.'
            format.html { redirect_to(@article) }
          else
            format.html { render :action => "edit" }
          end
        end
      end
    else
      redirect_to_edit_after_create_image
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
    end
  end

  def feed
    @articles = Article.publishing
    respond_to do |format|
      format.xml { render :layout => nil }
      format.rdf { render :layout => nil }
    end
  end

  private
  def redirect_to_edit_after_create_image
    image = Image.new(params[:image])
    @article.images << image
    @article.user = current_user
    @article.save!
    redirect_to(:action => 'edit', :id => @article.id)
  end

  def accessible_articles
    signed_in? ? Article : Article.publishing
  end
end
