require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesController do
  describe "route generation" do

    it "should map { :controller => 'articles', :action => 'index' } to /articles" do
      route_for(:controller => "articles", :action => "index").should == "/articles"
    end
  
    it "should map { :controller => 'articles', :action => 'new' } to /articles/new" do
      route_for(:controller => "articles", :action => "new").should == "/articles/new"
    end
  
    it "should map { :controller => 'articles', :action => 'show', :id => 1 } to /articles/1" do
      route_for(:controller => "articles", :action => "show", :id => 1).should == "/articles/1"
    end
  
    it "should map { :controller => 'articles', :action => 'edit', :id => 1 } to /articles/1/edit" do
      route_for(:controller => "articles", :action => "edit", :id => 1).should == "/articles/1/edit"
    end
  
    it "should map { :controller => 'articles', :action => 'update', :id => 1} to /articles/1" do
      route_for(:controller => "articles", :action => "update", :id => 1).should == "/articles/1"
    end
  
    it "should map { :controller => 'articles', :action => 'destroy', :id => 1} to /articles/1" do
      route_for(:controller => "articles", :action => "destroy", :id => 1).should == "/articles/1"
    end
  end

  describe "route recognition" do

    it "should generate params { :controller => 'articles', action => 'index' } from GET /articles" do
      params_from(:get, "/articles").should == {:controller => "articles", :action => "index"}
    end
  
    it "should generate params { :controller => 'articles', action => 'new' } from GET /articles/new" do
      params_from(:get, "/articles/new").should == {:controller => "articles", :action => "new"}
    end
  
    it "should generate params { :controller => 'articles', action => 'create' } from POST /articles" do
      params_from(:post, "/articles").should == {:controller => "articles", :action => "create"}
    end
  
    it "should generate params { :controller => 'articles', action => 'show', id => '1' } from GET /articles/1" do
      params_from(:get, "/articles/1").should == {:controller => "articles", :action => "show", :id => "1"}
    end
  
    it "should generate params { :controller => 'articles', action => 'edit', id => '1' } from GET /articles/1;edit" do
      params_from(:get, "/articles/1/edit").should == {:controller => "articles", :action => "edit", :id => "1"}
    end
  
    it "should generate params { :controller => 'articles', action => 'update', id => '1' } from PUT /articles/1" do
      params_from(:put, "/articles/1").should == {:controller => "articles", :action => "update", :id => "1"}
    end
  
    it "should generate params { :controller => 'articles', action => 'destroy', id => '1' } from DELETE /articles/1" do
      params_from(:delete, "/articles/1").should == {:controller => "articles", :action => "destroy", :id => "1"}
    end
  end
end