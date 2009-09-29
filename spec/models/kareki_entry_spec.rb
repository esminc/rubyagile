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

describe KarekiEntry do
  describe "#create_from_item" do
    before do
      feed = RSS::Parser.parse(File.read(File.expand_path("spec/fixtures/feeds/hatena_ursm.rss", Rails.root)))
      @item = feed.items.first

      @entry = KarekiEntry.build_from_item(@item)
    end

    subject { @entry }
    it { should be_valid }
    it { should be_new_record }

    describe ".content" do
      subject{ @entry.content }
      it{ should =~ /<p>こういうアクションに対して<\/p>/ }
    end
  end
end
