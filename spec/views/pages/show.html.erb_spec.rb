require File.dirname(__FILE__) + '/../../spec_helper'

describe "/pages/show.html.erb" do
  include PagesHelper

  before(:each) do
    @page = mock_model(Page, :null_object => true)
    assigns[:page] = @page

    template.stub_render(:partial => 'navigation')
    template.expect_render(:partial => 'page')
  end

  it "should render attributes" do
    render "/pages/show.html.erb"
  end
end
