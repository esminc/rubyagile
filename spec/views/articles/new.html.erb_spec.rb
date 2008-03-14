require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/new.html.erb" do
  include ArticlesHelper

  before(:each) do
    login_as(:alice)
    @article = mock_model(Article)
    @article.stub!(:new_record?).and_return(true)
    @article.stub!(:author_name).and_return("an author")
    @article.stub!(:user_id).and_return(1)
    @article.stub!(:title).and_return("an article title")
    @article.stub!(:body).and_return("an article body")
    @article.stub!(:published).and_return(0)
    assigns[:article] = @article
  end

  it "should render new form" do
    render "/articles/new.html.erb"
    response.should have_tag("form[action=?][method=post]", articles_path) do

    end
  end
end
