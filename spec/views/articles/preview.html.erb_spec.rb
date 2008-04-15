require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/preview" do
  before(:each) do
    login_as(:alice)
    article = mock_model(Article,
      :title => "t", :body => "b", :login => "l",
      :author_name => 'an', :user_id => 1)
    article.should_receive(:published).and_return(0)
    assigns[:article] = article
    template.should_receive(:parse_article).with(article)
    render 'articles/preview'
  end

  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('div.preview')
  end
end
