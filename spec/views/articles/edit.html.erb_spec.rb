require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/edit.html.erb" do
  include ArticlesHelper

  before do
    login_as(:valid)
    @article = mock_model(Article)
    @article.stub!(:title).and_return("an article title")
    @article.stub!(:body).and_return("an article body")

    assigns[:article] = @article
  end

  it "should render edit form" do
    render "/articles/edit.html.erb"

    response.should have_tag("form[action=#{article_path(@article)}][method=post]") do
    end
  end
end
