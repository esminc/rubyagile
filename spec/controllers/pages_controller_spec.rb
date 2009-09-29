require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  before(:each) do
    login_as(:alice)
  end

  describe "handling GET /pages/FrontPage" do
    before(:each) do
      @page = mock_model(Page)
      stub(controller).fetch_named_page("FrontPage") { @page }
      get :show, :page_name => "FrontPage"
    end

    it "should assign the found page for the view" do
      assigns[:page].should == @page
    end

    it { response.should be_success }
    it { response.should render_template('show') }
  end

  describe "handling GET /pages/new" do
    before(:each) do
      @page = mock_model(Page)
      dont_allow(@page).save
      stub(Page).new { @page }
      get :new
    end

    it { response.should be_success }
    it { response.should render_template('new') }
    it { @page.user.should == users(:alice) }

    it "should assign the new page for the view" do
      assigns[:page].should equal(@page)
    end
  end

  describe "handling GET /pages/FrontPage/edit" do
    before(:each) do
      @page = mock_model(Page)
      stub(controller).fetch_named_page("MyPage") { @page }
      get :edit, :page_name => "MyPage"
    end

    it { response.should be_success }
    it { response.should render_template('edit') }
    it "should assign the found Page for the view" do
      assigns[:page].should == @page
    end
  end

  describe "handling POST /pages" do
    before(:each) do
      @page = mock_model(Page, :to_param => "1")
      stub(Page).new { @page }
    end

    describe "with preview" do
      before do
        dont_allow(@page).save
        post :create, :page => {}, :preview => 'Preview'
      end
      it { response.should render_template('preview') }
    end
  end

  describe "handling PUT /pages/FrontPage" do
    before(:each) do
      @page = mock_model(Page, :page_name => "FirstPage")
      stub(controller).fetch_named_page("MyPage") { @page }
    end

    describe "with successful update" do
      before do
        mock(@page).update_attributes({'name' => 'NewName'}) { true }
        put :update, :page_name => "MyPage", :page => {:name => 'NewName'}
      end

      it { assigns(:page).should equal(@page) }
      it { response.should redirect_to(page_url("NewName")) }
    end

    describe "with failed update" do
      before do
        stub(@page).update_attributes(anything) { false }
        put :update, :page_name => "MyPage"
      end

      it { response.should render_template('edit') }
    end

    describe "with preview" do
      before do
        dont_allow(@page).update_attributes
        put(:update,
          :page_name => 'MyPage',
          :page => {:name => 'NewName', :content => 'new content'},
          :preview => 'Preview')
      end

      it { assigns[:page].name.should == 'NewName' }
      it { assigns[:page].content.should == 'new content' }
      it { response.should render_template('preview') }
    end
  end


  describe "handling Atomfeed" do
    before do
      @page = mock_model(Page, :to_param => "1")
      stub(Page).find { @page }
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
