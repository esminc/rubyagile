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
    before do
      @actual = parse(<<-EOS)
{{"<span>html literally.</span>"}}
      EOS
    end

    it {
      @actual.should == <<-EXPECTED
<span>html literally.</span>
      EXPECTED
    }
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
WikiName<a href="/pages/WikiName/new">?</a>
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
WikiName1<a href="/pages/WikiName1/new">?</a>
WikiName2<a href="/pages/WikiName2/new">?</a>
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
