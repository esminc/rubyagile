require File.dirname(__FILE__) + '/../spec_helper'

describe WikiEngine do
  def parse(text)
    wiki_engine = WikiEngine.new
    wiki_engine.render_text(text)
  end

  describe "normal text" do
    before do
      @actual = parse(<<-EOS)
! heading 3
paragraph.
      EOS
    end

    it {
      @actual.should == <<-EXPECTED
<h3>heading 3</h3>
<p>paragraph.</p>
      EXPECTED
    }
  end

  describe "plugin for html literally" do
    describe 'simple case' do
      subject { parse(<<-ACTUAL) }
{{"<span>html literally.</span>"}}
      ACTUAL

      it { should == (<<-EXPECTED) }
<span>html literally.</span>
      EXPECTED
    end

    describe 'amazon associate' do
      subject { parse(<<-ACTUAL) }
{{'<iframe src="http://rcm-jp.amazon.co.jp/e/cm?t=kakutani-22&o=9&p=8&l=as1&asins=4873113164&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>'}}
      ACTUAL

      it { should == (<<-EXPECTED) }
<iframe src="http://rcm-jp.amazon.co.jp/e/cm?t=kakutani-22&o=9&p=8&l=as1&asins=4873113164&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>
      EXPECTED
    end

    describe 'amazon associate を2回連続で貼ったとき' do
      subject { parse(<<-ACTUAL) }
{{"<iframe src='http://rcm-jp.amazon.co.jp/e/cm?t=kakutani-22&o=9&p=8&l=as1&asins=4798119881&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr' style='width:120px;height:240px;' scrolling='no' marginwidth='0' marginheight='0' frameborder='0'></iframe>"}}
{{'<iframe src="http://rcm-jp.amazon.co.jp/e/cm?t=kakutani-22&o=9&p=8&l=as1&asins=4873113164&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe>'}}
      ACTUAL

      it { should == (<<-EXPECTED) }
<p><span class="plugin"><iframe src='http://rcm-jp.amazon.co.jp/e/cm?t=kakutani-22&o=9&p=8&l=as1&asins=4798119881&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr' style='width:120px;height:240px;' scrolling='no' marginwidth='0' marginheight='0' frameborder='0'></iframe></span>
<span class="plugin"><iframe src="http://rcm-jp.amazon.co.jp/e/cm?t=kakutani-22&o=9&p=8&l=as1&asins=4873113164&fc1=000000&IS2=1&lt1=_blank&m=amazon&lc1=0000FF&bc1=000000&bg1=FFFFFF&f=ifr" style="width:120px;height:240px;" scrolling="no" marginwidth="0" marginheight="0" frameborder="0"></iframe></span></p>
      EXPECTED
    end

  end


  describe "WikiNameのリンクを含むHTML" do
    before(:each) do
    end

    it "WikiName" do
    end
  end

  def replace(text)
    wiki_engine = WikiEngine.new
    wiki_engine.replace_text(text)
  end

  describe "存在していないページのWikiNameの場合" do
    before(:each) do
      @actual = replace(<<-EOS)
<a href="WikiName">WikiName</a>
      EOS
    end

    it "WikiNameに?を付けた未解決のWikiNameに変換する" do
      @actual.should == <<-EXPECTED
WikiName<a href="/pages/new?page_name=WikiName">?</a>
      EXPECTED
    end
  end

  describe "存在していないページのWikiNameが複数存在する場合" do
    before(:each) do
      @actual = replace(<<-EOS)
<a href="WikiName1">WikiName1</a>
<a href="WikiName2">WikiName2</a>
      EOS
    end

    it "存在しないWikiNameすべてに?を付けて未解決のWikiNameに変換する" do
      @actual.should == <<-EXPECTED
WikiName1<a href="/pages/new?page_name=WikiName1">?</a>
WikiName2<a href="/pages/new?page_name=WikiName2">?</a>
      EXPECTED
    end
  end

  describe "http://から始る外部リンク" do
    before(:each) do
      @actual = replace(<<-EOS)
<a href="http://example.com">http://example.com</a>
      EOS
    end

    it "そのままの文字列である" do
      @actual.should == <<-EXPECTED
<a href="http://example.com">http://example.com</a>
      EXPECTED
    end
  end

end
