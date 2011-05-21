# coding: utf-8
require 'spec_helper'

describe 'ページの表示' do
  before do
    login_as User.make
    visit '/'
  end

  it 'indexページにアクセスするとFrontPageにリダイレクトする'
  it 'ページ名FrontPageにアクセスすると内容が表示される'
end
