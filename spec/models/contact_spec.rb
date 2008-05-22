require File.dirname(__FILE__) + '/../spec_helper'

describe Contact do
  before(:each) do
    @contact = Contact.new(
      :email => "text@example.com", :message => "foo bar baz.",
      :ip_address => "127.0.0.1")
  end

  it "should be valid" do
    @contact.should be_valid
  end
end
