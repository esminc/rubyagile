require 'spec_helper'

describe PagesController do
  before do
    login_as(:alice)
  end

  describe "GET /pages" do
    before do
      get :index
    end

    it { response.should be_redirect }
    it { response.should redirect_to page_path('FrontPage') }

  end

  describe "GET /pages/FrontPage" do
    before do
      @page = Page.new
      stub(Page).find_by_name!('FrontPage'){ @page }
      get :show, :id => 'FrontPage'
    end

    it "should assign the found page for the view" do
      assigns[:page].should == @page
    end

    it { response.should be_success }
    it { response.should render_template('show') }
  end

  describe "GET /pages/new" do
    before do
      @page = mock_model(Page)
      @page.should_not_receive(:save)
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

  describe "GET /pages/MyPage/edit" do
    before do
      @page = Page.make(:name => 'MyPage')
      get :edit, :id => 'MyPage'
    end

    it { response.should be_success }
    it { response.should render_template('edit') }
    it "should assign the found Page for the view" do
      assigns[:page].should == @page
    end
  end

  describe "POST /pages" do
    before do
      @page = mock_model(Page, :to_param => "1")
      stub(Page).new { @page }
    end

    describe "with preview" do
      before do
        @page.should_not_receive(:save)
        post :create, :page => {}, :preview => 'Preview'
      end
      it { response.should render_template('preview') }
    end
  end

  describe "PUT /pages/FrontPage" do
    before do
      @page = Page.make(:name => 'MyPage')
    end

    describe "with successful update" do
      before do
        put :update, :id => "MyPage", :page => {:name => 'NewName'}
      end

      it { assigns(:page).id.should == @page.id }
      it { assigns(:page).name.should == 'NewName' }
      it { response.should redirect_to(page_url("NewName")) }
    end

    describe "with failed update" do
      before do
        put :update, :id => "MyPage", :page => {:name => ''}
      end

      it { response.should render_template('edit') }
    end

    describe "with preview" do
      before do
        @page.should_not_receive(:update_attributes)
        put(:update,
          :id => 'MyPage',
          :page => {:name => 'NewName', :content => 'new content'},
          :preview => 'Preview')
      end

      it { assigns[:page].name.should == 'NewName' }
      it { assigns[:page].content.should == 'new content' }
      it { response.should render_template('preview') }
    end
  end


  describe "GET /pages/feed.xml" do
    before do
      @page = mock_model(Page, :to_param => "1")
      stub(Page).find { @page }
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
