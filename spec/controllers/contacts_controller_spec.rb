require File.dirname(__FILE__) + '/../spec_helper'

describe ContactsController do

  #Delete these examples and add some real ones
  it "should use ContactsController" do
    controller.should be_an_instance_of(ContactsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'confirm'" do
    it "should be successful" do
      get 'confirm'
      response.should be_success
    end
  end

  describe "GET 'done'" do
    it "should be successful" do
      get 'done'
      response.should be_success
    end
  end
end
