require File.dirname(__FILE__) + '/../spec_helper'

describe Article do
  fixtures :users

  def valid_article
    Article.new(:user => users(:alice), :title => 't', :body => 'b')
  end

  describe "必要な項目が揃っている場合" do
    before(:each) do
      @article = valid_article
    end

    it { @article.should be_valid }
    it { @article.next_article.should be_nil}
    it { @article.prev_article.should be_nil}

  end

  describe "コメントがある場合" do
    before do
      @article = valid_article
      2.times do |i|
        @article.comments.build(
          :author => "a#{i}", :body => "b#{i}", :ip_address => '127.0.0.1', :spam => false)
      end
    end

    it { @article.comment_count.should == 2 }
  end

  describe "#prev_article / #next_article" do
    before do
      3.times { valid_article.save }
      @oldest, @middle, @newest = Article.find(:all, :order => "id")
    end

    describe "一番古い記事" do
      it { @oldest.prev_article.should be_nil }
      it { @oldest.next_article.should == @middle }
    end

    describe "真ん中の記事" do
      it { @middle.prev_article.should == @oldest }
      it { @middle.next_article.should == @newest }
    end

    describe "一番新しい記事" do
      it { @newest.prev_article.should == @middle }
      it { @newest.next_article.should be_nil }
    end
  end

end
