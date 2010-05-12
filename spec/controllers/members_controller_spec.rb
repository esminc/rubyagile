require 'spec_helper'

describe MembersController do
  describe 'GET /show' do
    before do
      @user = User.make(:login => 'ursm')
      get :show, :id => 'ursm'
    end

    it { response.should be_success }
    it { assigns[:member].should == @user }
  end
end
