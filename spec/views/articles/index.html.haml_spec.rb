require 'spec_helper'

describe "/articles/index.html.haml" do
  include ArticlesHelper

  describe "when empty" do
    before(:each) do
      assigns[:articles] = []
      assigns[:entries] = []
      view.should_receive(:render).with(:partial => 'sidebar')
    end

    it "should render list of articles" do
      render "/articles/index.html.haml"
    end
  end
end
