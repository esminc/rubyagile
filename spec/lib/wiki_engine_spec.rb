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

end
