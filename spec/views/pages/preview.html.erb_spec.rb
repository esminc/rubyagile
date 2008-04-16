require File.dirname(__FILE__) + '/../../spec_helper'

describe "/pages/preview" do
  before(:each) do
    login_as(:alice)
    page = mock_model(Page,
      :name => "t", :content => "b", :login => "l",
      :author_name => 'an', :user_id => 1)
    assigns[:page] = page
    template.should_receive(:parse_page).with(page)
    render 'pages/preview'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('div.preview')
  end
end
