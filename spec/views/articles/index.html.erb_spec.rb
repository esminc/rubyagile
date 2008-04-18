require File.dirname(__FILE__) + '/../../spec_helper'

describe "/articles/index.html.erb" do
  include ArticlesHelper

  describe "when empty" do
    before(:each) do
      assigns[:articles] = []
      template.expect_render(:partial => 'shared/sidebar')
    end

    it "should render list of articles" do
      render "/articles/index.html.erb"
    end
  end
end
