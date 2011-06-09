# coding: utf-8
require 'spec_helper'

describe 'karekiエントリの管理' do
  before do
    visit '/signout'
  end

  context 'ログインしていない時' do
    before do
      visit '/kareki_entries'
    end

    it 'ログインページにリダイレクトされる' do
      page.should have_content '外部サービスを利用してログイン'
    end
  end

  context 'ログインしている時' do
    before do
      @feed = KarekiFeed.new(:title => 'alpha', :url => 'http://example.com').tap{|feed|
        feed.stub(:build_feed)
        feed.save!
      }
      @entry = KarekiEntry.make(:title => 'bravo', :content => 'example', :link => 'http://examle.com', :feed => @feed)

      User.make(:authentications => [Authentication.make], :feeds => [@feed])
      visit '/signin'
      click_link 'twitter'

      visit '/kareki_entries'
    end

    it 'karekiエントリを公開する' do
      click_link 'Confirm'
      visit '/'

      page.should have_content @entry.title
    end

    it 'karekiエントリを非公開にする' do
      click_link 'Reject'
      visit '/'

      page.should_not have_content @entry.title
    end
  end
end
