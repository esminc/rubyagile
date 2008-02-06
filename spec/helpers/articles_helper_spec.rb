require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesHelper do

  #Delete this example and add some real ones or delete this file
  it "should include the ArticlesHelper" do
    included_modules = self.metaclass.send :included_modules
    included_modules.should include(ArticlesHelper)
  end

  describe "utility for date and time" do
    before do
      @time = Time.parse("2008-02-01 13:45:26")
    end

    it "posted_on works" do
      posted_on(@time).should == "2008-02-01"
    end
  end
end
