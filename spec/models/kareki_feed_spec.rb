require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiFeed do
  def create_ursm_hatena
    feed = KarekiFeed.new(:url => 'http://d.hatena.ne.jp/ursm/rss')
    stub(feed).feed_content do
      File.read(File.join(Rails.root, "spec/fixtures/feeds/hatena_ursm.rss"))
    end
    feed.save
    feed
  end

  describe '#new' do
    context "適切なurlのとき" do
      before do
        @feed = create_ursm_hatena
      end

      subject { @feed }

      it { should be_valid }
      it { subject.url.should == 'http://d.hatena.ne.jp/ursm/rss' }
      it { subject.title.should == 'ursmの日記' }
      it { subject.link.should == 'http://d.hatena.ne.jp/ursm/' }

      context "存在しないフィードが指定されたとき" do
        before do
          @feed = KarekiFeed.new(:url => "http://example.com/not_exist/rss")
        end
        subject{ @feed }
        it{ should_not be_exist }
      end
    end
  end

  describe "#fetch_and_save_entries" do
    context "happy case" do
      before do
        dummy_feed = Object.new
        mock(@feed = create_ursm_hatena).parse_feed_content { dummy_feed }
        mock(@feed).create_entries_from(dummy_feed)
      end
      specify "call private methods" do
        @feed.fetch_and_save_entries
      end
    end
  end
end
