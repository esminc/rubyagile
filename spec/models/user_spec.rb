require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  def valid_user
    { :login => "s-kakutani", :email => "s-kakutani@esm.co.jp",
      :open_id_url => "http://kakutani.com/"}
  end

  describe "when valid" do
    before(:each) do
      @user = User.new(valid_user)
    end

    it { @user.should be_valid }
    it { @user.should_not be_member}

  end

  describe "when admin user" do
    before do
      @user = User.new(valid_user.merge(:member => "true"))
    end

    it { @user.should be_member}
  end

end