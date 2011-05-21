# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  def valid_user
    {
      :login => "s-kakutani",
      :email => "s-kakutani@esm.co.jp",
      :open_id_url => "http://kakutani.com/"
    }
  end

  describe "when valid" do
    before(:each) do
      @user = User.new(valid_user)
    end

    it { @user.should be_valid }
    it { @user.should_not be_nakanohito}
    it { @user.to_param.should == 's-kakutani' }
  end

  describe "when admin user" do
    before do
      @user = User.new(valid_user.merge(:nakanohito => "true"))
    end

    it { @user.should be_nakanohito}
  end

  describe '#accepted_rate' do
    context '何もないとき' do
      before do
        @user = User.make
      end

      subject { @user }
      its(:accepted_rate) { should == 0.0 }
    end

    context '公開されている日記が3つあって、そのうちの1つが自分' do
      before do
        @user = User.make

        feed = KarekiFeed.new(:owner => @user)
        feed.stub(:build_feed)
        feed.save
        KarekiEntry.make(:feed => feed, :confirmation => 'confirmed')

        others = KarekiFeed.new(:url => 'http://example.com')
        others.stub(:build_feed)
        others.save

        Array.new(2) { KarekiEntry.make(:title => 'example', :content => 'example', :feed_id => others.id, :confirmation => 'confirmed') }
      end

      subject { @user }
      it { KarekiEntry.should have(3).records }
      its(:accepted_rate) { should be_within(0.01).of(33.33) }
    end
  end
end
