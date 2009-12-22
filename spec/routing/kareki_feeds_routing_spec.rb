require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiFeedsController do
  describe "route generation" do
    it "maps #index" do
      route_for(:controller => "kareki_feeds", :action => "index").should == "/kareki_feeds"
    end

    it "maps #new" do
      route_for(:controller => "kareki_feeds", :action => "new").should == "/kareki_feeds/new"
    end

    it "maps #show" do
      route_for(:controller => "kareki_feeds", :action => "show", :id => "1").should == "/kareki_feeds/1"
    end

    it "maps #edit" do
      route_for(:controller => "kareki_feeds", :action => "edit", :id => "1").should == "/kareki_feeds/1/edit"
    end

    it "maps #create" do
      route_for(:controller => "kareki_feeds", :action => "create").should == {:path => "/kareki_feeds", :method => :post}
    end

    it "maps #update" do
      route_for(:controller => "kareki_feeds", :action => "update", :id => "1").should == {:path =>"/kareki_feeds/1", :method => :put}
    end

    it "maps #destroy" do
      route_for(:controller => "kareki_feeds", :action => "destroy", :id => "1").should == {:path =>"/kareki_feeds/1", :method => :delete}
    end
  end

  describe "route recognition" do
    it "generates params for #index" do
      params_from(:get, "/kareki_feeds").should == {:controller => "kareki_feeds", :action => "index"}
    end

    it "generates params for #new" do
      params_from(:get, "/kareki_feeds/new").should == {:controller => "kareki_feeds", :action => "new"}
    end

    it "generates params for #create" do
      params_from(:post, "/kareki_feeds").should == {:controller => "kareki_feeds", :action => "create"}
    end

    it "generates params for #show" do
      params_from(:get, "/kareki_feeds/1").should == {:controller => "kareki_feeds", :action => "show", :id => "1"}
    end

    it "generates params for #edit" do
      params_from(:get, "/kareki_feeds/1/edit").should == {:controller => "kareki_feeds", :action => "edit", :id => "1"}
    end

    it "generates params for #update" do
      params_from(:put, "/kareki_feeds/1").should == {:controller => "kareki_feeds", :action => "update", :id => "1"}
    end

    it "generates params for #destroy" do
      params_from(:delete, "/kareki_feeds/1").should == {:controller => "kareki_feeds", :action => "destroy", :id => "1"}
    end
  end
end
