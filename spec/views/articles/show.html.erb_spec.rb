require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/show.html.erb" do
  include ArticlesHelper

  before(:each) do
    @article = mock_model(Article, :null_object => true)
    @article.stub!(:body).and_return("my article")
    assigns[:article] = @article
  end

  it "should render attributes" do
    render "/articles/show.html.erb"
  end
end
