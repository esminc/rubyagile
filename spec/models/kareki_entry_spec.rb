# -*- coding: utf-8 -*-
require 'spec_helper'

describe KarekiEntry do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :content => "value for content",
      :link => "value for link",
      :confirmation => "not_yet",
      :published_at => Time.now,
      :creator => "value for creator",
      :feed_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    KarekiEntry.create!(@valid_attributes)
  end

  describe "confirmation" do
    before do
      @entry = KarekiEntry.create!(@valid_attributes)
    end
    subject{ @entry.confirmation }
    it{ should be_not_yet }

    describe "confirmed" do
      before do
        @entry.confirmation = "confirmed"
      end
      it{ should be_confirmed }
    end
  end

  describe "#create_from_entry" do
    context 'rss' do
      before do
        feed = Feedzirra::Feed.parse(Rails.root.join('spec/fixtures/feeds/hatena_ursm.rss').read)
        @item = feed.entries.first

        @entry = KarekiEntry.build_from_entry(@item)
        @entry.feed_id = 1 # dummy
      end

      subject { @entry }
      it { should be_valid }
      it { should be_new_record }

      its(:content) { should =~ /<p>こういうアクションに対して<\/p>/ }
      its(:summary) { should =~ /^こういうアクションに対して/ }

      describe "もう一度おなじitemで上書きする場合" do
        before do
          @entry.save
          @item.stub(:content) { "Hehehe" }
          @updated = KarekiEntry.build_from_entry(@item)
        end

        subject { @updated }
        it { should == @entry }
        its(:content) { should == "Hehehe" }
      end
    end

    context 'atom' do
      before do
        pending
        feed = Feedzirra::Feed.parse(Rails.root.join('spec/fixtures/feeds/blogger_kenchan.atom').read)
        @item = feed.entries.first

        @entry = KarekiEntry.build_from_entry(@item)
        @entry.feed_id = 1 # dummy
      end

      subject { @entry }
      it { should be_valid }
      it { should be_new_record }

      its(:content) { should =~ %r(<li>Ruby</li>) }
      its(:summary) { should =~ /^Keep/ }

      describe "もう一度おなじitemで上書きする場合" do
        before do
          @item.stub(:content) { 'Hehehe' }
          @entry.save
          @updated = KarekiEntry.build_from_entry(@item)
        end

        subject { @updated }
        it { should == @entry }
        its(:content) { should == "Hehehe" }
      end
    end
  end
end
