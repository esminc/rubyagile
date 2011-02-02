require File.dirname(__FILE__) + '/../spec_helper'

describe Contact do
  before(:each) do
    @contact = Contact.new(
      :email => "text@example.com", :message => "foo bar baz.",
      :ip_address => "127.0.0.1")
  end

  it "should be bot" do
    @contact.should be_bot
  end

  it "should_not be valid" do
    @contact.should_not be_valid
    @contact.errors[:bot].should_not be_empty
  end

end
