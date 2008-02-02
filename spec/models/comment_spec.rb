require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
  before(:each) do
    @comment = Comment.new(:author => 'foo', :body => 'bar', :ip_address => '127.0.0.1')
  end

  it "should be valid" do
    @comment.should be_valid
  end
end
