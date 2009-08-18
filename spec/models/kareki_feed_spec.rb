require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiFeed do
  describe 'Feed を新しく作るとき' do
    before do
      @feed = KarekiFeed.new(:url => 'http://d.hatena.ne.jp/ursm/rss')
      @feed.save
    end

    subject { @feed }

    it { should be_valid }
    it { subject.url.should == 'http://d.hatena.ne.jp/ursm/rss' }
    it { subject.title.should == 'ursmの日記' }
    it { subject.link.should == 'http://d.hatena.ne.jp/ursm/' }
  end
end
