require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/index.html.erb" do
  include ArticlesHelper

  before(:each) do
    article_98 = mock_model(Article, :null_object => true)
    article_99 = mock_model(Article, :null_object => true)

    assigns[:articles] = [article_98, article_99]
  end

  it "should render list of articles" do
    render "/articles/index.html.erb"
  end
end
