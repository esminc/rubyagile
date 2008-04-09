require File.dirname(__FILE__) + '/../spec_helper'

describe DashboardHelper do
  include DashboardHelper

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
