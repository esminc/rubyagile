# coding: utf-8
require 'spec_helper'

describe 'トップページの表示' do
  before do
    @article = Article.make(:publishing => true)

    @feed = KarekiFeed.new(:title => 'alpha', :url => 'http://example.com')
    @feed.stub(:build_feed)
    @feed.save
    KarekiEntry.make(:title => 'bravo', :content => 'example', :feed => @feed, :link => 'http://examle.com')

    visit '/'
  end

  it '記事が表示されている' do
    page.should have_content @article.title
  end

  it 'Karekiが表示されている' do
    page.should have_content @feed.title
    page.should have_content @feed.entries.first.title
  end
end
