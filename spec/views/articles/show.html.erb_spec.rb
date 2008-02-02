require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/show.html.erb" do
  include ArticlesHelper

  before(:each) do
    @article = mock_model(Article, :null_object => true)
    assigns[:article] = @article
    template.should_receive(:link_to_comments).and_return("link to comments")
    template.should_receive(:parse).and_return("parsed body")
  end

  it "should render attributes" do
    render "/articles/show.html.erb"
  end
end
