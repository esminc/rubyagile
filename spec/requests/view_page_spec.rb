# coding: utf-8
require 'spec_helper'

describe 'ページの表示' do
  before do
    @front_page = Page.make
    @page = Page.make(:name => 'TestPage', :content => 'Test Content')
  end

  it 'indexページにアクセスするとFrontPageにリダイレクトする' do
    visit '/pages/'
    page.should have_content @front_page.content
  end

  it 'ページ名にアクセスすると内容が表示される' do
    visit '/pages/TestPage'
    page.should have_content @page.content
  end
end
