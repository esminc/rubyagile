# coding: utf-8
require 'spec_helper'

describe 'karekiエントリの管理' do
  before do
    login_as User.make
    visit '/'
  end

  context 'ログインしていない時'
  context 'ログインしている時' do
    it 'karekiエントリを公開する'
    it 'karekiエントリを非公開にする'
  end
end
