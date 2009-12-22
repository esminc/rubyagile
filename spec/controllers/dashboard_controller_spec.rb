require File.dirname(__FILE__) + '/../spec_helper'

describe DashboardController do
  describe "GET 'index'" do
    before do
      login_as(:alice)
      mock(Article).find_all_written_by(current_user)
      get 'index'
    end

    it "should be successful" do
      response.should be_success
    end
  end
end
