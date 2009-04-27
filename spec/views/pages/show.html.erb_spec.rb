require File.dirname(__FILE__) + '/../../spec_helper'

describe "/pages/show.html.erb" do
  include PagesHelper

  before(:each) do
    @page = mock_model(Page, :null_object => true)
    assigns[:page] = @page

    template.stub!(:render).with(:partial => 'navigation')
    template.should_receive(:render).with(:partial => 'shared/page')
  end

  it "should render attributes" do
    render "/pages/show.html.erb"
  end
end
