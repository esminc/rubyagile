# -*- coding: utf-8 -*-
class ArticlesController < ApplicationController
  before_filter :login_required, :except => [:show, :index, :feed]

  def index
    @articles = Article.publishing.page(params[:page])
  end

  def show
    @article = Article.find(params[:id])

    redirect_to signin_path(origin: request.path) unless @article.publishing? || signed_in?
  rescue ActiveRecord::RecordNotFound
    flash[:error] = '指定した記事は存在しません。'
    redirect_to root_path
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
      redirect_to(:action => 'edit', :id => @article.id)
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
      redirect_to(:action => 'edit', :id => @article.id)
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
    @articles = Article.publishing.limit(10)

    respond_to do |format|
      format.rss { render :layout => nil }
    end
  end
end
