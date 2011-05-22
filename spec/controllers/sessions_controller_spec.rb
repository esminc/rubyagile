require 'spec_helper'

describe SessionsController do
  describe "POST 'create'" do
    before do
      controller.stub(:authenticate!)
      controller.should_receive(:authenticate!)
    end
    it "should be successful" do
      post 'create', :openid_identifier => 'http://example.com'
      response.should redirect_to(root_path)
    end
  end

  describe "DELETE 'destroy'" do
    before do
      controller.stub(:logout)
      controller.should_receive(:logout)
      delete :destroy
    end

    it { flash[:notice].should == 'You have been sign out.'}
    it { response.should redirect_to(root_path)}
  end
end
