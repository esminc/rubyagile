require File.dirname(__FILE__) + '/../spec_helper'

describe PagesController do
  before(:each) do
    login_as(:alice)
  end

  describe "handling GET /pages/FrontPage" do
    before(:each) do
      @page = mock_model(Page)
      Page.stub!(:find).and_return(@page)
      Page.should_receive(:find_by_name).with("FrontPage").and_return(@page)
      get :show, :page_name => "FrontPage"
    end

    it { response.should be_success }
    it { response.should render_template('show') }
    it "should assign the found page for the view" do
      assigns[:page].should equal(@page)
    end
  end

=begin
  describe "handling GET /pages/new" do
    before(:each) do
      @page = mock_model(Page)
      Page.should_receive(:new).and_return(@page)
      @page.should_receive(:user=).with(users(:alice))
      get :new
    end

    it { response.should be_success }
    it { response.should render_template('new') }
    it { @page.should_not_receive(:save) }

    it "should assign the new page for the view" do
      assigns[:page].should equal(@page)
    end
  end
=end

  describe "handling GET /pages/FrontPage/edit" do
    before(:each) do
      @page = mock_model(Page)
      Page.should_receive(:find_by_name).with("FrontPage").and_return(@page)
      get :edit, :page_name => "FrontPage"
    end

    it { response.should be_success }
    it { response.should render_template('edit') }
    it "should assign the found Page for the view" do
      assigns[:page].should equal(@page)
    end
  end

  describe "handling POST /pages" do
    before(:each) do
      @page = mock_model(Page, :to_param => "1")
      Page.stub!(:new).and_return(@page)
    end

  end

# PEND このテストが上手く行かない原因を調べること
=begin
  describe "handling PUT /pages/FrontPage" do
    before(:each) do
      @page = mock_model(Page, :to_param => "FrontPage")
      Page.stub!(:find_by_name).with("FrontPage").and_return(@page)
    end

    describe "with successful update" do
      before do
        Page.should_receive(:find_by_name).with("FrontPage").and_return(@page)
        @page.should_receive(:update_attributes).and_return(true)
        put :update, :page_name => "FrontPage"
      end

      it { assigns(:page).should equal(@page) }
      it { response.should redirect_to(page_url("FrontPage")) }
    end

    describe "with failed update" do
      before do
        @page.should_receive(:update_attributes).and_return(false)
        put :update, :page_name => "FrontPage"
      end

      it { response.should render_template('edit') }
    end
  end
=end
end
