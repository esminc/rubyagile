require 'spec_helper'

describe SessionsController do
  describe "GET 'new'" do
    before do
      get 'new'
    end
    it { response.should render_template("sessions/new")}
  end

  describe "POST 'create'" do
    before do
      mock(controller).authenticate!
    end
    it "should be successful" do
      post 'create', :openid_identifier => 'http://example.com'
      response.should redirect_to(root_path)
    end
  end

  describe "DELETE 'destroy'" do
    before do
      mock(controller).logout
      delete :destroy
    end

    it { flash[:notice].should == 'You have been sign out.'}
    it { response.should redirect_to("")}
  end
end
