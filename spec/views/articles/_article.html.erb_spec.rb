require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/_article.html.erb" do
  include ArticlesHelper

  describe "when empty" do
    before(:each) do
      @article = mock_model(Article, :null_object => true)
      user = mock_model(User, :login => 'a_user')
      @article.stub!(:user).and_return(user)

      template.stub!(:link_to_comments)
      template.stub!(:posted_on)
      template.stub!(:parse_article)
    end

    it "should render list of articles" do
      render :partial => "articles/article", :locals => { :article => @article}
    end
  end
end
