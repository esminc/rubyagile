# -*- coding: utf-8 -*-
require 'spec_helper'

describe KarekiFeed do
  def create_ursm_hatena
    feed = KarekiFeed.new(:url => 'http://d.hatena.ne.jp/ursm/rss')

    feed.stub(:parse_feed_content) {
      Feedzirra::Feed.parse(File.read(File.join(Rails.root, "spec/fixtures/feeds/hatena_ursm.rss")))
    }

    feed.tap(&:save!)
  end

  describe '.nakanohitos' do
    let!(:nakanohito_feed) { Fabricate(:feed, owner: Fabricate(:nakanohito)) }
    let!(:sotonohito_feed) { Fabricate(:feed, owner: Fabricate(:sotonohito)) }

    subject { KarekiFeed.nakanohitos }
    it { should == [nakanohito_feed] }
  end

  describe '#new' do
    context "適切なurlのとき" do
      before do
        @feed = create_ursm_hatena
      end

      subject { @feed }

      it { should be_valid }
      it { subject.url.should == 'http://d.hatena.ne.jp/ursm/rss' }
      it { subject.title.should == 'ursmの日記' }
      it { subject.link.should == 'http://d.hatena.ne.jp/ursm/' }

      context "存在しないフィードが指定されたとき" do
        before do
          @feed = KarekiFeed.new(:url => "http://example.com/not_exist/rss")
        end
        subject{ @feed }
        it { should be_present }
      end

      context "同じフィードを複数登録しようとしたとき" do
        before do
          @feed.save!
        end

        subject { KarekiFeed.new(:url => @feed.url) }
        it { should have(1).errors_on(:url) }
      end
    end
  end

  describe "#fetch_and_save_entries" do
    context "happy case" do
      before do
        dummy_feed = Object.new
        @feed = create_ursm_hatena
        @feed.stub(:parse_feed_content) { dummy_feed }
        @feed.should_receive(:create_entries_from).with(dummy_feed)
      end
      specify "call private methods" do
        @feed.fetch_and_save_entries
      end
    end

    context "同じエントリを再度取得してしまった場合" do
      before do
        @feed = create_ursm_hatena
        @feed.fetch_and_save_entries
      end
      it "KarekiEntryがダブッて保存されないこと。" do
        expect{ @feed.fetch_and_save_entries }.should_not change(KarekiEntry, :count)
      end
    end
  end

  describe "#crawl" do
    specify "naive implementation" do
      KarekiFeed.should_receive(:nakanohitos) {
        feed = KarekiFeed.new
        feed.should_receive(:fetch_and_save_entries)
        [feed]
      }

      KarekiFeed.crawl
    end
  end
end
