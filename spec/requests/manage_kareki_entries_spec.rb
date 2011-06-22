# coding: utf-8
require 'spec_helper'

describe 'karekiエントリの管理' do
  context 'ログインしていない時' do
    before do
      visit '/kareki_entries'
    end

    it 'ログインページにリダイレクトされる' do
      page.should have_content '外部サービスを利用してログイン'
    end
  end

  context 'ログインしている時', login: true do
    let!(:feed)  { Fabricate(:feed) }
    let!(:entry) { Fabricate(:entry, feed: feed) }

    before do
      visit '/kareki_entries'
    end

    it 'karekiエントリを公開する' do
      click_link 'Confirm'
      visit '/'

      page.should have_content entry.title
    end

    it 'karekiエントリを非公開にする' do
      click_link 'Reject'
      visit '/'

      page.should_not have_content entry.title
    end
  end
end
