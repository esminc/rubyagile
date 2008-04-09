require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesHelper do
  include ArticlesHelper
  it { ArticlesHelper.ancestors.should be_include(HikidocHelper) }

  describe "utility for date and time" do
    before do
      @time = Time.parse("2008-02-01 13:45:26")
    end

    it "posted_on works" do
      posted_on(@time).should == "2008-02-01"
    end
  end

  describe "#link_to_comments" do
    describe "with no comment" do
      before do
        @article = mock_model(Article, :comment_count => 0)
      end
      it { link_to_comments(@article).should have_tag('a', 'Not Yet Commented') }
    end

    describe "with some comments" do
      before do
        @article = mock_model(Article, :comment_count => 2)
      end
      it { link_to_comments(@article).should have_tag('a', '2 Comments')}
    end

  end
end
