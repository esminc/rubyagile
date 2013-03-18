# coding: utf-8
require 'spec_helper'

describe 'ダッシュボードの表示', login: true do
  let!(:article) { Fabricate(:article, user: user) }

  before do
    visit '/dashboard'
  end

  it '自分の記事が表示されている' do
    page.should have_content(article.title)
  end
end
