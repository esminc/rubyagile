require File.dirname(__FILE__) + '/../spec_helper'

describe Article do

  def valid_article
    Article.new(:user => users(:alice), :title => 't', :body => 'b', :published => 1)
  end

  describe "デフォルト値について" do
    before do
      @article = Article.new
    end

    it { @article.should_not be_published }
  end


  describe "必要な項目が揃っている場合" do
    before(:each) do
      @article = valid_article
    end

    it { @article.should be_valid }
  end

  describe "コメントがある場合" do
    before do
      @article = valid_article
      2.times do |i|
        @article.comments.build(
          :author => "a#{i}", :body => "b#{i}", :ip_address => '127.0.0.1', :spam => false)
      end
    end

    it "should have 2 comments" do
      @article.comment_count.should == 2
    end
  end

  describe "1件しか記事が無い場合" do
    before do
      Article.delete_all
      @article = valid_article
      valid_article.save!
    end

    it { @article.next_article.should be_nil}
    it { @article.prev_article.should be_nil}
  end

  describe "前後に記事が存在する場合" do
    before do
      Article.delete_all
      3.times { valid_article.save }
      @newest, @middle, @oldest = Article.find(:all, :order => "id DESC")
    end

    describe "一番古い記事について" do
      it "should be nil in prev_article" do
        @oldest.prev_article.should be_nil
      end

      it "should have next article" do
        @oldest.next_article.should == @middle
      end
    end

    describe "真ん中の記事について" do
      it "should have previous article" do
        @middle.prev_article.should == @oldest
      end

      it "should have next article" do
        @middle.next_article.should == @newest
      end
    end

    describe "一番新しい記事について" do
      it "should have previous article" do
        @newest.prev_article.should == @middle
      end

      it "should be nil in next article" do
        @newest.next_article.should be_nil
      end
    end
  end

end

describe Article, "#published?" do
  before do
    @article = Article.new
  end

  describe "when checked" do
    before do
      @article.published = 1
    end
    it { @article.should be_published }
  end

  describe "when non-checked" do
    before do
      @article.published = 0
    end
    it { @article.should_not be_published }
  end

end
