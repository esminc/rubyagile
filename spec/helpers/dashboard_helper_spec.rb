require File.dirname(__FILE__) + '/../spec_helper'

describe DashboardHelper do

  #Delete this example and add some real ones or delete this file
  it "should include the DashboardHelper" do
    included_modules = self.metaclass.send :included_modules
    included_modules.should include(DashboardHelper)
  end

  describe "#render_status_for" do
    describe "when published" do
      before do
        article = mock_model(Article, :published? => true)
        @result = render_status_for(article)
      end

      it { @result.should == "公開" }
    end

    describe "when in draft" do
      before do
        article = mock_model(Article, :published? => false)
        @result = render_status_for(article)
      end

      it { @result.should == "草稿" }
    end
  end
end
