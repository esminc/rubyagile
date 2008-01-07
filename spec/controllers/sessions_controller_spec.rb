require File.dirname(__FILE__) + '/../spec_helper'

describe SessionsController do

  #Delete these examples and add some real ones
  it "should use SessionsController" do
    controller.should be_an_instance_of(SessionsController)
  end


  describe "GET 'create'" do
    it "should be successful" do
      pending("it's spike time.")
      get 'create'
      response.should be_success
    end
  end
end
