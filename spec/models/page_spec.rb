# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper'

describe Page do
  def valid_page
    Page.new(:user => users(:alice), :name => 't', :content => 'b')
  end

  describe "必要な項目が揃っている場合" do
    before(:each) do
      @page = valid_page
    end

    it { @page.should be_valid }
  end

  describe "既存のページ名と同じ名前のページを作成するとき" do
    before(:each) do
      valid_page.save
    end

    it { valid_page.save.should == false }

    it {
      expect {
        valid_page.save!
      }.to raise_error(ActiveRecord::RecordInvalid)
    }
  end
end
