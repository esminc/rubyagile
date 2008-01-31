require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/index.html.erb" do
  include UsersHelper

  before(:each) do
    user_98 = mock_model(User)
    user_98.should_receive(:login).and_return("MyString")
    user_98.should_receive(:nickname).and_return("MyString")
    user_98.should_receive(:email).and_return("MyString")
    user_98.should_receive(:open_id_url).and_return("MyString")
    user_98.should_receive(:amazon_associate).and_return("MyString")
    user_98.should_receive(:aboutme_url).and_return("MyString")
    user_98.should_receive(:admin).and_return(false)
    user_99 = mock_model(User)
    user_99.should_receive(:login).and_return("MyString")
    user_99.should_receive(:nickname).and_return("MyString")
    user_99.should_receive(:email).and_return("MyString")
    user_99.should_receive(:open_id_url).and_return("MyString")
    user_99.should_receive(:amazon_associate).and_return("MyString")
    user_99.should_receive(:aboutme_url).and_return("MyString")
    user_99.should_receive(:admin).and_return(false)

    assigns[:users] = [user_98, user_99]
  end

  it "should render list of users" do
    render "/users/index.html.erb"
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "MyString", 2)
    response.should have_tag("tr>td", "false", 2)
  end
end
