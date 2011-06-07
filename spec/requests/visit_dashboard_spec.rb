# coding: utf-8
require 'spec_helper'

describe 'ダッシュボードの表示' do
  before do
    @article = Article.make
    login_as User.make(:authentications => [Authentication.make], :articles => [@article])
    visit '/signin'
    click_link 'twitter'

    visit '/dashboard'
  end

  it '自分の記事が表示されている' do
    page.should have_content @article.title
  end
end
