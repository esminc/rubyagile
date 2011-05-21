# coding: utf-8
require 'spec_helper'

describe '記事の表示' do
  before do
    login_as User.make
    visit '/'
  end

  it '記事の一覧が表示される'
  it '記事一件の表示'
end
