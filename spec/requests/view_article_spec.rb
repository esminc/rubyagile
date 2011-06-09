# coding: utf-8
require 'spec_helper'

describe '記事の表示' do
  before do
    visit '/signout'

    @article = Article.make(:publishing => true)
    visit '/'
  end

  it '記事の一覧が表示される' do
    page.should have_content @article.title
  end

  it '記事一件の表示' do
    click_link @article.title
    page.should have_content @article.body
  end
end
