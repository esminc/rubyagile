require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/preview" do
  before(:each) do
    login_as(:alice)
    article = mock_model(Article, :title => "t", :body => "b", :login => "l")
    assigns[:article] = article
    render 'articles/preview'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('div.preview')
  end
end
