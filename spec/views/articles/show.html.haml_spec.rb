require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/show.html.haml" do
  include ArticlesHelper

  before :each do
    @article = mock_model(Article).as_null_object
    assigns[:article] = @article

    view.stub!(:render).with(:partial => 'navigation')
    view.should_receive(:render).with(:partial => 'shared/article')
  end

  it "should render attributes" do
    render "/articles/show.html.haml"
  end
end
