# coding: utf-8
require 'spec_helper'

describe 'ページの編集' do
  before do
    visit '/signout'

    User.make(:authentications => [Authentication.make])
    visit '/signin'
    click_link 'twitter'

    visit '/'
  end

  context '新規作成できる' do
    it '草稿に保存する'
    it 'そのまま公開する'
    it '新規作成に失敗する'
    it 'プレビュー'
  end

  context '更新できる' do
    it '成功'
    it '失敗'
    it 'プレビュー'
  end

  it '削除できる'
end
