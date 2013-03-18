# -*- coding: utf-8 -*-

require 'spec_helper'

describe 'トップページの表示' do
  let!(:article) { Fabricate(:article) }
  let!(:feed)    { Fabricate(:feed) }
  let!(:entry)   { Fabricate(:entry, feed: feed) }

  before do
    visit '/'
  end

  it '記事が表示されている' do
    page.should have_content(article.title)
  end

  it 'Karekiが表示されている' do
    page.should have_content(feed.title)
    page.should have_content(entry.title)
  end
end
