require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users/edit.html.erb" do
  include UsersHelper
  
  before do
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

  it "should render edit form" do
    render "/users/edit.html.erb"
    
    response.should have_tag("form[action=#{user_path(@user)}][method=post]") do
      with_tag('input#user_login[name=?]', "user[login]")
      with_tag('input#user_nickname[name=?]', "user[nickname]")
      with_tag('input#user_email[name=?]', "user[email]")
      with_tag('input#user_aboutme_url[name=?]', "user[aboutme_url]")
      with_tag('input#user_admin[name=?]', "user[admin]")
    end
  end
end


