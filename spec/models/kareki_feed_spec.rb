require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe KarekiFeed do
  describe 'Feed を新しく作るとき' do
    before do
      @feed = KarekiFeed.new(:url => 'http://d.hatena.ne.jp/ursm/rss')
      @feed.save
    end

    subject { @feed }

    it { should be_valid }
    it { subject.title.should == 'ursmの日記' }
  end
end
