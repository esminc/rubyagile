require File.dirname(__FILE__) + '/../../spec_helper'

describe "/pages/_page.html.erb" do
  include PagesHelper

  describe "when empty" do
    before(:each) do
      @page = mock_model(Page, :null_object => true)
      user = mock_model(User, :login => 'a_user')
      @page.stub!(:user).and_return(user)

      template.stub!(:link_to_comments)
      template.stub!(:posted_on)
      template.stub!(:parse_page)
    end

    it "should render list of pages" do
      render :partial => "shared/page", :locals => { :page => @page }
    end
  end
end
