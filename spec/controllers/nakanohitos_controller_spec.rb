require 'spec_helper'

describe NakanohitosController do
  describe 'GET /show' do
    before do
      @user = User.make(:login => 'ursm')
      get :show, :id => 'ursm'
    end

    it { response.should be_success }
    it { assigns[:nakanohito].should == @user }
  end
end
