require 'spec_helper'

describe "/sessions/new" do
  before(:each) do
    render 'sessions/new'
  end

  it { response.should be_success }
end
