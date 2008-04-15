require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/show.html.erb" do
  include ArticlesHelper

  before(:each) do
    @article = mock_model(Article, :null_object => true)
    assigns[:article] = @article

    template.stub_render(:partial => 'navigation')
    template.expect_render(:partial => 'article')
  end

  it "should render attributes" do
    render "/articles/show.html.erb"
  end
end
