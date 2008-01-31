require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/new.html.erb" do
  include UsersHelper

  before(:each) do
    @user = mock_model(User)
    @user.stub!(:new_record?).and_return(true)
    @user.stub!(:login).and_return("MyString")
    @user.stub!(:fullname).and_return("MyString")
    @user.stub!(:email).and_return("MyString")
    @user.stub!(:open_id_url).and_return("MyString")
    @user.stub!(:amazon_associate).and_return("MyString")
    @user.stub!(:member?).and_return(false)
    assigns[:user] = @user
  end

  it "should render new form" do
    render "/users/new.html.erb"

    response.should have_tag("form[action=?][method=post]", users_path) do
      with_tag("input#user_login[name=?]", "user[login]")
      with_tag("input#user_fullname[name=?]", "user[fullname]")
      with_tag("input#user_email[name=?]", "user[email]")
    end
  end
end
