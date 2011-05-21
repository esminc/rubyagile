# coding: utf-8
require 'spec_helper'

describe 'ダッシュボードの表示' do
  before do
    login_as User.make
    visit '/dashboard'
  end

  it '自分の記事が表示されている'
end
