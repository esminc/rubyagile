require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/edit.html.erb" do
  include ArticlesHelper

  before do
    login_as(:alice)
    @article = mock_model(Article)
    stub(@article) {
      author_name { "an author" }
      user_id { 1 }
      title { "an article title" }
      body { "an article body" }
      publishing { 0 }
      images { [] }
    }
    assigns[:article] = @article
  end

  it "should render edit form" do
    render "/articles/edit.html.erb"

    response.should have_tag("form[action=#{article_path(@article)}][method=post]") do
    end
  end
end
