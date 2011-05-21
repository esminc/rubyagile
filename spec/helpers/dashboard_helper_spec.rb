# -*- coding: utf-8 -*-
require 'spec_helper'

describe DashboardHelper do
  include DashboardHelper

  describe "#render_status_for" do
    describe "when publishing" do
      before do
        article = mock_model(Article, :publishing? => true)
        @result = render_status_for(article)
      end

      it { @result.should == "公開" }
    end

    describe "when in draft" do
      before do
        article = mock_model(Article, :publishing? => false)
        @result = render_status_for(article)
      end

      it { @result.should == "草稿" }
    end
  end
end
