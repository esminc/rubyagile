require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/new.html.erb" do
  include ArticlesHelper

  before(:each) do
    login_as(:valid)
    @article = mock_model(Article)
    @article.stub!(:new_record?).and_return(true)
    @article.stub!(:title).and_return("an article title")
    @article.stub!(:body).and_return("an article body")

    assigns[:article] = @article
  end

  it "should render new form" do
    render "/articles/new.html.erb"
    response.should have_tag("form[action=?][method=post]", articles_path) do

    end
  end
end
