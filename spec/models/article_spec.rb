# -*- coding: utf-8 -*-
require 'spec_helper'

describe Article do
  describe '1件しか記事が無い場合' do
    subject { Fabricate(:article) }

    its(:next_article) { should_not be }
    its(:prev_article) { should_not be }
  end

  describe '前後に記事が存在する場合' do
    let!(:oldest) { Fabricate(:article) }
    let!(:middle) { Fabricate(:article) }
    let!(:newest) { Fabricate(:article) }

    describe '一番古い記事について' do
      subject { oldest }

      its(:prev_article) { should_not be }
      its(:next_article) { should == middle }
    end

    describe '真ん中の記事について' do
      subject { middle }

      its(:prev_article) { should == oldest }
      its(:next_article) { should == newest }
    end

    describe '一番新しい記事について' do
      subject { newest }

      its(:prev_article) { should == middle }
      its(:next_article) { should_not be }
    end
  end

  describe '.publishing' do
    let!(:published) { Fabricate(:article, publishing: true) }
    let!(:draft)     { Fabricate(:article, publishing: false) }

    subject { Article.publishing }

    it { should be_include(published) }
    it { should_not be_include(draft) }
  end

  describe '.all' do
    let!(:new) { Fabricate(:article, created_at: 1.days.ago) }
    let!(:old) { Fabricate(:article, created_at: 2.days.ago) }

    subject { Article.all }

    it '新しいものから順に並ぶこと' do
      should == [new, old]
    end
  end
end
