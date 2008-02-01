require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do
  describe "GET 'new'" do
    before do
      get 'new'
    end
    it { response.should render_template("sessions/new")}
  end

  describe "GET 'create'" do
    before do
      controller.should_receive(:open_id_authentication)
    end
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end
end
