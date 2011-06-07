# coding: utf-8
require 'spec_helper'

describe 'ページの編集' do
  before do
    login_as User.make(:authentications => [Authentication.make])
    visit '/signin'
    click_link 'twitter'

    visit '/'
  end

  it '新規作成できる'
  context '更新できる' do
    it '成功'
    it '失敗'
    it 'プレビュー'
  end
end
