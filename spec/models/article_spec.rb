# -*- coding: utf-8 -*-
require 'spec_helper'

module ArticleFactory
  def valid_article(opts = {})
    paramz = {:user => users(:alice), :title => 't', :body => 'b', :publishing => true}.merge(opts)
    Article.new(paramz)
  end
end

describe Article do
  include ArticleFactory

  describe "デフォルト値について" do
    before do
      @article = Article.new
    end

    it { @article.should_not be_publishing }
  end


  describe "必要な項目が揃っている場合" do
    before(:each) do
      @article = valid_article
    end

    it { @article.should be_valid }
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

  describe "#publishing?" do
    before do
      @article = Article.new
    end

    describe "when checked" do
      before do
        @article.publishing = true
      end
      it { @article.should be_publishing }
    end

    describe "when non-checked" do
      before do
        @article.publishing = false
      end
      it { @article.should_not be_publishing }
    end
  end

  describe '.publishing' do
    subject{ Article.publishing }
    before do
      [ @draft = Article.create!,
        @pub = Article.create! ]
      @pub.update_attribute(:publishing, true)
      @draft.update_attribute(:publishing, false)
    end

    it { should include(@pub) }
    it { should_not include(@draft) }
  end

  describe '.newer_first' do
    before do
      Article.delete_all
      @articles = [
        valid_article(:created_at => 1.days.ago ).tap(&:save!),
        valid_article(:created_at => 2.days.ago ).tap(&:save!),
      ]
    end
    subject{ Article.newer_first }

    it { should == @articles }
  end
end
