# coding: utf-8
require 'spec_helper'

describe '中の人ページの表示' do
  before do
    login_as User.make
    visit '/'
  end

  context '中の人の個人ページを表示したとき' do
    it '中の人が書いた記事が表示される'
    it '中の人のエントリが表示される'
  end
end
