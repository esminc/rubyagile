require 'spec_helper'

describe "/articles/new.html" do
  include ArticlesHelper

  before(:each) do
    login_as(:alice)
    @article = Article.make
    assigns[:article] = @article

    render "/articles/new.html"
  end

  it "should render new form" do
    response.should have_tag("form[action=?][method=post]", articles_path)
  end
end
