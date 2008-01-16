require File.dirname(__FILE__) + '/../spec_helper'

describe Article do
  fixtures :users
  
  before(:each) do
    @article = Article.new(:user => users(:valid))
  end

  it "should be valid" do
    @article.should be_valid
  end
end
