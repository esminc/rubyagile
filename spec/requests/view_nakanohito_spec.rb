# coding: utf-8
require 'spec_helper'

describe '中の人ページの表示' do
  before do
    @article = Article.make(:title => 'alpha', :body => 'bravo', :publishing => true)

    feed = KarekiFeed.new(:owner => @user)
    feed.stub(:build_feed)
    feed.save
    @entry = KarekiEntry.make(:confirmation => 'confirmed',:feed => feed, :link => 'http://examle.com')

    @user = User.make(:login => 'alice', :articles => [@article], :feeds => [feed], :nakanohito => true)

    visit "/nakanohitos/#{@user.login}"
  end

  context '中の人の個人ページを表示したとき' do
    it '中の人が書いた記事が表示される' do
      page.should have_content @article.title
    end

    it '中の人のエントリが表示される' do
      page.should have_content @entry.title
    end
  end
end
