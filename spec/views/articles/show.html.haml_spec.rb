require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/show.html.haml" do
  include ArticlesHelper

  before :each do
    @article = mock_model(Article, :null_object => true)
    assigns[:article] = @article

    template.stub!(:render).with(:partial => 'navigation')
    template.should_receive(:render).with(:partial => 'shared/article')
  end

  it "should render attributes" do
    render "/articles/show.html.haml"
  end
end
