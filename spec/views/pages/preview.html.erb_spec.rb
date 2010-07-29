require File.dirname(__FILE__) + '/../../spec_helper'

describe "/pages/preview" do
  before(:each) do
    login_as(:alice)
    page = Page.make(:name => 'HelloWorld')
    mock(template).parse_page(page)
    assigns[:page] = page

    render 'pages/preview'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('div.preview')
  end
end
