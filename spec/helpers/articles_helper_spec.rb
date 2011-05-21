require 'spec_helper'

describe ArticlesHelper do
  include ArticlesHelper

  describe "utility for date and time" do
    before do
      @time = Time.parse("2008-02-01 13:45:26")
    end

    it "posted_on works" do
      posted_on(@time).should == "2008-02-01"
    end
  end

  describe "#link_to_comments" do
    before do
      @article = mock_model(Article, :to_param => '5')
    end

    subject { link_to_comments(@article) }
    it { should have_tag('a[href=/articles/5#disqus_thread]', 'View Comments') }
  end
end
