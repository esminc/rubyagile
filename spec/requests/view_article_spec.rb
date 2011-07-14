# coding: utf-8
require 'spec_helper'

describe 'トップページには' do
  let!(:article) { Fabricate(:article) }

  before do
    visit '/'
  end

  it '記事のタイトルが表示されていること' do
    page.should have_content article.title
  end

  it 'タイトルをクリックすると、本文が表示されること' do
    click_link article.title
    page.should have_content(article.body)
  end
end

describe '存在しないページにアクセスした時は' do
  let!(:article) { Fabricate(:article) }

  before do
    visit "/articles/#{article.id}"
  end

  it 'エラーにならずにトップページが表示されていること' do
    page.should have_content(article.title)
  end
end
