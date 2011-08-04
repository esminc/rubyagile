# coding: utf-8
require 'spec_helper'

describe 'ページの表示' do
  let!(:front_page) { Fabricate(:front_page) }
  let!(:test_page)  { Fabricate(:page, name: 'TestPage') }

  context 'indexページにアクセスする' do
    before do
      visit '/pages/'
    end

    it { page.should have_content(front_page.content) }
  end

  context 'ページ名を指定してアクセスする' do
    before do
      visit '/pages/TestPage'
    end

    it { page.should have_content(test_page.content) }
  end
end

describe '存在しないページにアクセスした時は', login: true do
  before do
    visit '/pages/TestPage'
  end

  it 'エラーにならずに新規作成ページが表示されていること' do
    page.should have_content 'ページの作成'
  end
end
