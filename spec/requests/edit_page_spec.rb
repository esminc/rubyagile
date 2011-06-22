# coding: utf-8
require 'spec_helper'

describe 'ページの編集', login: true do
  before do
    visit '/'
  end

  it '新規作成できる'
  context '更新できる' do
    it '成功'
    it '失敗'
    it 'プレビュー'
  end
end
