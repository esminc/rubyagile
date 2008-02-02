require File.dirname(__FILE__) + '/../spec_helper'

describe Comment do
  describe "by human" do
    before(:each) do
      @comment = Comment.new(:author => 'foo', :body => 'bar', :ip_address => '127.0.0.1', :spam => nil)
    end

    it "should be valid" do
      @comment.should be_valid
    end

    it "should not be spam" do
      @comment.should_not be_spam
    end
  end

  describe "markes as spam" do
    before do
      @comment = Comment.new(:spam => true)
    end

    it { @comment.should be_spam}
  end

  describe "#parse_request" do
    describe "with valid params" do
      before do
        params = {:author => "me", :body => "comment body",
          :article_id => 1, :ip_address => "127.0.0.1"}
        @comment = Comment.parse_params(params)
      end

      it "should not be spam" do
        @comment.should_not be_spam
      end

      it "should be valid" do
        @comment.should be_valid
      end
    end

    describe "with spam" do
      before do
        params = {:author => "me", :body => "comment body", :email => "spammer@example.com",
          :article_id => 1, :ip_address => "127.0.0.1"}
        @comment = Comment.parse_params(params)

        it "should be spam" do
          @comment.should be_spam
        end

        it "should be valid" do
          @comment.should be_valid
        end
      end
    end
  end
end
