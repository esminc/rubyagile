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

  describe "全文検索インデックスを追加する場合" do
    fixtures :articles
    before do
      @article = articles(:hikidoc_sample)
      @old_record_timestamps = Article.record_timestamps
      Article.record_timestamps = false
    end

    after do
      Article.record_timestamps = @old_record_timestamps
    end

    xit "検索対象のフィールド, title が変更された場合はconnectionのput_docが呼ばれること" do
      mock(Article.estraier_connection).put_doc
      @article.title = "new title"
      @article.save
    end

    xit "検索対象でないフィールド, publishing が変更された場合はconnectionのput_docが呼ばれないこと" do
      dont_allow(Article.estraier_connection).put_doc
      @article.publishing = !@article.publishing
      @article.save
    end
  end

  describe "全文検索をし、検索対象に全てのArticleが含まれる場合" do
    fixtures :articles
    before do
      mock(Article).matched_ids("検索語", :order=>"@mdate NUMD") {
        [articles(:hikidoc_sample).id, articles(:draft).id] }
    end

    xit "追加の検索条件を指定しない場合には全ての文書がヒットすること" do
      as = Article.find_fulltext("検索語")
      as.length.should == 2
    end

    xit ":publishing => trueという追加の検索条件を指定すると:hikidoc_sampleのみがヒットすること" do
      as = Article.find_fulltext("検索語", :conditions=>["publishing = ?", true])
      as.should == [articles(:hikidoc_sample)]
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

  describe ".find_all_by_user_id" do
    it "作成日時の降順であること" do
      mock(Article).find_all_by_user_id(users(:alice).id, {:order => "created_at DESC"})
      Article.find_all_written_by(users(:alice))
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
