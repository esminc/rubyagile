require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/new.html.erb" do
  include ArticlesHelper

  before(:each) do
    login_as(:alice)
    @article = mock_model(Article)
    stub(@article) {
      new_record { true }
      author_name { "an author" }
      user_id { 1 }
      title { "an article title" }
      body { "an article body" }
      publishing { 0 }
      images { [] }
    }
    assigns[:article] = @article
  end

  it "should render new form" do
    render "/articles/new.html.erb"
    response.should have_tag("form[action=?][method=post]", articles_path) do

    end
  end
end
