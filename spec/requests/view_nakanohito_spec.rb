# coding: utf-8
require 'spec_helper'

describe '中の人ページの表示' do
  let(:user)     { Fabricate(:user) }
  let!(:article) { Fabricate(:article, user: user) }
  let!(:feed)    { Fabricate(:feed, owner: user) }
  let!(:entry)   { Fabricate(:entry, feed: feed) }

  before do
    visit "/nakanohitos/#{user.login}"
  end

  context '中の人の個人ページを表示したとき' do
    it '中の人が書いた記事が表示される' do
      page.should have_content(article.title)
    end

    it '中の人のエントリが表示される' do
      page.should have_content(entry.title)
    end
  end
end
