require 'spec_helper'

describe "/contacts/index" do
  before(:each) do
    assigns[:contact] = Contact.new
    render 'contacts/index'
  end

  it { response.should have_tag('h2') }
end
