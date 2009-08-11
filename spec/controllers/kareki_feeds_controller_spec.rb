require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiFeedsController do

  def mock_kareki_feed(stubs={})
    @mock_kareki_feed ||= mock_model(KarekiFeed, stubs)
  end

  describe "GET index" do
    it "assigns all kareki_feeds as @kareki_feeds" do
      KarekiFeed.stub!(:find).with(:all).and_return([mock_kareki_feed])
      get :index
      assigns[:kareki_feeds].should == [mock_kareki_feed]
    end
  end

  describe "GET show" do
    it "assigns the requested kareki_feed as @kareki_feed" do
      KarekiFeed.stub!(:find).with("37").and_return(mock_kareki_feed)
      get :show, :id => "37"
      assigns[:kareki_feed].should equal(mock_kareki_feed)
    end
  end

  describe "GET new" do
    it "assigns a new kareki_feed as @kareki_feed" do
      KarekiFeed.stub!(:new).and_return(mock_kareki_feed)
      get :new
      assigns[:kareki_feed].should equal(mock_kareki_feed)
    end
  end

  describe "GET edit" do
    it "assigns the requested kareki_feed as @kareki_feed" do
      KarekiFeed.stub!(:find).with("37").and_return(mock_kareki_feed)
      get :edit, :id => "37"
      assigns[:kareki_feed].should equal(mock_kareki_feed)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created kareki_feed as @kareki_feed" do
        KarekiFeed.stub!(:new).with({'these' => 'params'}).and_return(mock_kareki_feed(:save => true))
        post :create, :kareki_feed => {:these => 'params'}
        assigns[:kareki_feed].should equal(mock_kareki_feed)
      end

      it "redirects to the created kareki_feed" do
        KarekiFeed.stub!(:new).and_return(mock_kareki_feed(:save => true))
        post :create, :kareki_feed => {}
        response.should redirect_to(kareki_feed_url(mock_kareki_feed))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved kareki_feed as @kareki_feed" do
        KarekiFeed.stub!(:new).with({'these' => 'params'}).and_return(mock_kareki_feed(:save => false))
        post :create, :kareki_feed => {:these => 'params'}
        assigns[:kareki_feed].should equal(mock_kareki_feed)
      end

      it "re-renders the 'new' template" do
        KarekiFeed.stub!(:new).and_return(mock_kareki_feed(:save => false))
        post :create, :kareki_feed => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested kareki_feed" do
        KarekiFeed.should_receive(:find).with("37").and_return(mock_kareki_feed)
        mock_kareki_feed.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :kareki_feed => {:these => 'params'}
      end

      it "assigns the requested kareki_feed as @kareki_feed" do
        KarekiFeed.stub!(:find).and_return(mock_kareki_feed(:update_attributes => true))
        put :update, :id => "1"
        assigns[:kareki_feed].should equal(mock_kareki_feed)
      end

      it "redirects to the kareki_feed" do
        KarekiFeed.stub!(:find).and_return(mock_kareki_feed(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(kareki_feed_url(mock_kareki_feed))
      end
    end

    describe "with invalid params" do
      it "updates the requested kareki_feed" do
        KarekiFeed.should_receive(:find).with("37").and_return(mock_kareki_feed)
        mock_kareki_feed.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :kareki_feed => {:these => 'params'}
      end

      it "assigns the kareki_feed as @kareki_feed" do
        KarekiFeed.stub!(:find).and_return(mock_kareki_feed(:update_attributes => false))
        put :update, :id => "1"
        assigns[:kareki_feed].should equal(mock_kareki_feed)
      end

      it "re-renders the 'edit' template" do
        KarekiFeed.stub!(:find).and_return(mock_kareki_feed(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested kareki_feed" do
      KarekiFeed.should_receive(:find).with("37").and_return(mock_kareki_feed)
      mock_kareki_feed.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the kareki_feeds list" do
      KarekiFeed.stub!(:find).and_return(mock_kareki_feed(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(kareki_feeds_url)
    end
  end

end
