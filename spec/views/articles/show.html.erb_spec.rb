require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/show.html.erb" do
  include ArticlesHelper
  
  before(:each) do
    @article = mock_model(Article)

    assigns[:article] = @article
  end

  it "should render attributes in <p>" do
    render "/articles/show.html.erb"
  end
end

