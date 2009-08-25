require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiEntry do
  before(:each) do
    @valid_attributes = {
      :title => "value for title",
      :content => "value for content",
      :link => "value for link",
      :confirmed => false,
      :published_at => Time.now,
      :creator => "value for creator",
      :feed_id => 1
    }
  end

  it "should create a new instance given valid attributes" do
    KarekiEntry.create!(@valid_attributes)
  end
end
