require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiFeedsController do
  describe "route generation" do
    it "maps #index" do
      { :get => "/kareki_feeds" }.should route_to(:controller => "kareki_feeds", :action => "index")
    end

    it "maps #new" do
      { :get => "/kareki_feeds/new" }.should route_to(:controller => "kareki_feeds", :action => "new")
    end

    it "maps #show" do
      { :get => "/kareki_feeds/1" }.should route_to(:controller => "kareki_feeds", :action => "show", :id => "1")
    end

    it "maps #edit" do
      { :get => "/kareki_feeds/1/edit" }.should route_to(:controller => "kareki_feeds", :action => "edit", :id => "1")
    end

    it "maps #create" do
      { :post => "/kareki_feeds" }.should route_to(:controller => "kareki_feeds", :action => "create")
    end

    it "maps #update" do
      { :put => "/kareki_feeds/1" }.should route_to(:controller => "kareki_feeds", :action => "update", :id => "1")
    end

    it "maps #destroy" do
      { :delete => "/kareki_feeds/1" }.should route_to(:controller => "kareki_feeds", :action => "destroy", :id => "1")
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
