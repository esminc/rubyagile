require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/edit.html.erb" do
  include ArticlesHelper

  before do
    login_as(:alice)
    @article = mock_model(Article)
    @article.stub!(:author_name).and_return("an author")
    @article.stub!(:user_id).and_return(1)
    @article.stub!(:title).and_return("an article title")
    @article.stub!(:body).and_return("an article body")
    @article.stub!(:publishing).and_return(0)
    @article.stub!(:images).and_return([])
    assigns[:article] = @article
  end

  it "should render edit form" do
    render "/articles/edit.html.erb"

    response.should have_tag("form[action=#{article_path(@article)}][method=post]") do
    end
  end
end
