# coding: utf-8
require 'spec_helper'

describe 'ダッシュボードの表示' do
  before do
    visit '/signout'

    @article = Article.make
    User.make(:authentications => [Authentication.make], :articles => [@article])
    visit '/signin'
    click_link 'twitter'

    visit '/dashboard'
  end

  it '自分の記事が表示されている' do
    page.should have_content @article.title
  end
end
