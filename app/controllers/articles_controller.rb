class ArticlesController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :feed]

  def index
    @articles = Article.find(:all,
      :conditions => ["published is true"],
      :order => "created_at DESC") # TODO duplicated
    respond_to do |format|
      format.html
    end
  end

  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new
    @article = Article.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])
    @article.user = current_user

    unless params[:preview].blank?
      render :action => 'preview'
    else
      respond_to do |format|
        if @article.save
          flash[:notice] = 'Article was successfully created.'
          format.html { redirect_to(@article) }
        else
          format.html { render :action => "new" }
        end
      end
    end
  end

  def update
    @article = Article.find(params[:id])

    unless params[:preview].blank?
      @article.title = params[:article][:title]
      @article.body = params[:article][:body]
      render :action => 'preview'
    else
      respond_to do |format|
        if @article.update_attributes(params[:article])
          flash[:notice] = 'Article was successfully updated.'
          format.html { redirect_to(@article) }
        else
          format.html { render :action => "edit" }
        end
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
    end
  end

  def comment
    @article = Article.find(params[:id])
    params_for_comment = params[:comment].
      merge(:article_id => params[:id],
        :ip_address => request.remote_ip)
    comment = Comment.parse_params(params_for_comment)
    # TODO handle if comment.spam?
    comment.save
    redirect_to :action => 'show', :id => @article.id
  end

  def feed
    @articles = Article.find(:all, :order => "created_at DESC")
    respond_to do |format|
      format.xml { render :layout => nil }
      format.rdf { render :layout => nil }
    end
  end
end
