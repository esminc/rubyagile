require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/_article.html.erb" do
  include ArticlesHelper

  describe "when empty" do
    before(:each) do
      @article = mock_model(Article, :null_object => true)
      user = mock_model(User, :login => 'a_user')
      stub(@article).user { user }

      stub(template) {
        like_to_comments
        posted_on
        parse_article
      }
    end

    it "should render list of articles" do
      render :partial => "shared/article", :locals => { :article => @article}
    end
  end
end
