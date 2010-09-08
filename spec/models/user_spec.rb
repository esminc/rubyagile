require File.dirname(__FILE__) + '/../spec_helper'

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

        stub.instance_of(KarekiFeed).before_save

        feed = KarekiFeed.make(:owner => @user)
        KarekiEntry.make(:feed => feed, :confirmation => 'confirmed')

        others = KarekiFeed.make
        Array.new(2) { KarekiEntry.make(:feed => others, :confirmation => 'confirmed') }
      end

      subject { @user }
      it { KarekiEntry.should have(3).records }
      its(:accepted_rate) { should be_close(33.33, 0.01) }
    end
  end
end
