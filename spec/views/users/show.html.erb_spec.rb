require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/show.html.erb" do
  include UsersHelper
  
  before(:each) do
    @user = mock_model(User)
    @user.stub!(:login).and_return("MyString")
    @user.stub!(:nickname).and_return("MyString")
    @user.stub!(:email).and_return("MyString")
    @user.stub!(:open_id_url).and_return("MyString")
    @user.stub!(:amazon_associate_id).and_return("MyString")
    @user.stub!(:aboutme_url).and_return("MyString")
    @user.stub!(:admin).and_return(false)

    assigns[:user] = @user
  end

  it "should render attributes in <p>" do
    render "/users/show.html.erb"
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/MyString/)
    response.should have_text(/als/)
  end
end

