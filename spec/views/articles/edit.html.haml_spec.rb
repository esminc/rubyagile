require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/edit.html" do
  include ArticlesHelper

  before do
    login_as(:alice)
    @article = Article.make
    assigns[:article] = @article
  end

  it "should render edit form" do
    render "/articles/edit.html"

    response.should have_tag("form[action=#{article_path(@article)}][method=post]") do
    end
  end
end
