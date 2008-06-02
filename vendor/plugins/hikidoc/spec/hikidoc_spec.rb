require 'spec'
rootdir = "#{File::dirname(__FILE__)}/.."
require "#{rootdir}/lib/hikidoc"

describe HikiDoc do
  it "plugin" do
    assert_convert("<div class=\"plugin\">{{hoge}}</div>\n",
                   "{{hoge}}")
    assert_convert("<p>a<span class=\"plugin\">{{hoge}}</span>b</p>\n",
                   "a{{hoge}}b")
    assert_convert("<p>\\<span class=\"plugin\">{{hoge}}</span></p>\n",
                   "\\{{hoge}}")
    assert_convert("<p>a{{hoge</p>\n",
                   "a{{hoge")
    assert_convert("<p>hoge}}b</p>\n",
                   "hoge}}b")
    assert_convert("<p><span class=\"plugin\">{{hoge}}</span>\na</p>\n",
                   "{{hoge}}\na")
    assert_convert("<div class=\"plugin\">{{hoge}}</div>\n<p>a</p>\n",
                   "{{hoge}}\n\na")
  end

  it "plugin with quotes" do
    assert_convert("<div class=\"plugin\">{{hoge(\"}}\")}}</div>\n",
                   '{{hoge("}}")}}')
    assert_convert("<div class=\"plugin\">{{hoge(\'}}\')}}</div>\n",
                   "{{hoge('}}')}}")
    assert_convert("<div class=\"plugin\">{{hoge(\'\n}}\n\')}}</div>\n",
                   "{{hoge('\n}}\n')}}")
  end

  it "plugin with meta char" do
    assert_convert("<div class=\"plugin\">{{hoge(\"a\\\"b\")}}</div>\n",
                   '{{hoge("a\\"b")}}')
  end

  it "plugin with custom syntax" do
    assert_convert("<p>{{&lt;&lt;\"End\"\nfoo's bar\nEnd\n}}</p>\n",
                   "{{<<\"End\"\nfoo's bar\nEnd\n}}")

    options = {:plugin_syntax => method(:custom_valid_plugin_syntax?)}
    assert_convert(%Q|<div class="plugin">{{&lt;&lt;"End"\nfoo's bar\nEnd\n}}</div>\n|,
                   %Q!{{<<"End"\nfoo's bar\nEnd\n}}!,
                   options)
    assert_convert(%Q|<div class="plugin">{{&lt;&lt;"End"\nfoo\nEnd}}</div>\n|,
                   %Q!{{<<"End"\nfoo\nEnd}}!,
                   options)
  end

  it "blockquote" do
    assert_convert("<blockquote><p>hoge</p>\n</blockquote>\n",
                   %Q|""hoge\n|)
    assert_convert("<blockquote><p>hoge\nfuga</p>\n</blockquote>\n",
                   %Q|""hoge\n""fuga\n|)
    assert_convert("<blockquote><p>hoge</p>\n<blockquote><p>fuga</p>\n</blockquote>\n</blockquote>\n",
                   %Q|""hoge\n"" ""fuga\n|)
    assert_convert("<blockquote><h1>hoge</h1>\n</blockquote>\n",
                   %Q|"" ! hoge\n|)
    assert_convert("<blockquote><p>foo\nbar</p>\n<p>foo</p>\n</blockquote>\n",
                   %Q|""foo\n""bar\n""\n""foo|)
    assert_convert("<blockquote><p>foo\nbar</p>\n<h1>foo</h1>\n</blockquote>\n",
                   %Q|""foo\n""bar\n""!foo|)
    assert_convert("<blockquote><p>foo\nbar</p>\n<pre>baz</pre>\n</blockquote>\n",
                   %Q|""foo\n"" bar\n""  baz|)
    assert_convert("<blockquote><p>foo\nbar</p>\n<pre>baz</pre>\n</blockquote>\n",
                   %Q|""foo\n""\tbar\n""\t\tbaz|)
  end

  it "header" do
    assert_convert("<h1>hoge</h1>\n", "!hoge")
    assert_convert("<h2>hoge</h2>\n", "!! hoge")
    assert_convert("<h3>hoge</h3>\n", "!!!hoge")
    assert_convert("<h4>hoge</h4>\n", "!!!! hoge")
    assert_convert("<h5>hoge</h5>\n", "!!!!!hoge")
    assert_convert("<h6>hoge</h6>\n", "!!!!!! hoge")
    assert_convert("<h6>! hoge</h6>\n", "!!!!!!! hoge")

    assert_convert("<h1>foo</h1>\n<h2>bar</h2>\n",
                   "!foo\n!!bar")
  end

  it "list" do
    assert_convert("<ul>\n<li>foo</li>\n</ul>\n",
                   "* foo")
    assert_convert("<ul>\n<li>foo</li>\n<li>bar</li>\n</ul>\n",
                   "* foo\n* bar")
    assert_convert("<ul>\n<li>foo<ul>\n<li>bar</li>\n</ul></li>\n</ul>\n",
                   "* foo\n** bar")
    assert_convert("<ul>\n<li>foo<ul>\n<li>foo</li>\n</ul></li>\n<li>bar</li>\n</ul>\n",
                   "* foo\n** foo\n* bar")
    assert_convert("<ul>\n<li>foo<ol>\n<li>foo</li>\n</ol></li>\n<li>bar</li>\n</ul>\n",
                   "* foo\n## foo\n* bar")
    assert_convert("<ul>\n<li>foo</li>\n</ul><ol>\n<li>bar</li>\n</ol>\n",
                   "* foo\n# bar")
  end

  it "list skip" do
    assert_convert("<ul>\n<li>foo<ul>\n<li><ul>\n<li>foo</li>\n</ul></li>\n</ul></li>\n<li>bar</li>\n</ul>\n",
                   "* foo\n*** foo\n* bar")
    assert_convert("<ol>\n<li>foo<ol>\n<li><ol>\n<li>bar</li>\n<li>baz</li>\n</ol></li>\n</ol></li>\n</ol>\n",
                   "# foo\n### bar\n###baz")
  end

  it "hrules" do
    assert_convert("<hr />\n", "----")
    assert_convert("<p>----a</p>\n", "----a")
  end

  it "pre" do
    assert_convert("<pre>foo</pre>\n",
                   " foo")
    assert_convert("<pre>\\:</pre>\n",
                   ' \:')
    assert_convert("<pre>foo</pre>\n",
                   "\tfoo")
    assert_convert("<pre>foo\nbar</pre>\n",
                   " foo\n bar")
    assert_convert("<pre>foo\nbar</pre>\n",
                   " foo\n bar\n")
    assert_convert("<pre>&lt;foo&gt;</pre>\n",
                   " <foo>")
  end

  it "multi pre" do
    assert_convert("<pre>foo</pre>\n",
                   "<<<\nfoo\n>>>")
    assert_convert("<pre>foo\n bar</pre>\n",
                   "<<<\nfoo\n bar\n>>>")
    assert_convert("<pre>foo</pre>\n<pre>bar</pre>\n",
                   "<<<\nfoo\n>>>\n<<<\nbar\n>>>")
    assert_convert("<pre>&lt;foo&gt;</pre>\n",
                   "<<<\n<foo>\n>>>")
  end

  it "comment" do
    assert_convert("", "// foo")
    assert_convert("", "// foo\n")
  end

  it "paragraph" do
    assert_convert("<p>foo</p>\n", "foo")

    assert_convert("<p>foo</p>\n<p>bar</p>\n",
                   "foo\n\nbar")
    assert_convert("<p>foo</p>\n<p>bar</p>\n",
                   "foo\r\n\r\nbar")

    assert_convert("<p>foo </p>\n<p>b a r </p>\n",
                   "foo \n\nb a r ")
  end

  it "escape" do
    assert_convert(%Q|<p>\\"\\"foo</p>\n|,
                   %q|\"\"foo|)
  end

  it "link" do
    assert_convert(%Q|<p><a href="http://hikiwiki.org/">http://hikiwiki.org/</a></p>\n|,
                   "http://hikiwiki.org/")
    assert_convert(%Q|<p><a href="http://hikiwiki.org/">http://hikiwiki.org/</a></p>\n|,
                   "[[http://hikiwiki.org/]]")
    assert_convert(%Q|<p><a href="http://hikiwiki.org/">Hiki</a></p>\n|,
                   "[[Hiki|http://hikiwiki.org/]]")
    assert_convert(%Q|<p><a href="/hikiwiki.html">Hiki</a></p>\n|,
                   "[[Hiki|http:/hikiwiki.html]]")
    assert_convert(%Q|<p><a href="hikiwiki.html">Hiki</a></p>\n|,
                   "[[Hiki|http:hikiwiki.html]]")
    assert_convert(%Q|<p><img src="http://hikiwiki.org/img.png" alt="img.png" /></p>\n|,
                   "http://hikiwiki.org/img.png")
    assert_convert(%Q|<p><a href="http://hikiwiki.org/ja/?c=edit;p=Test">| +
                   %Q|http://hikiwiki.org/ja/?c=edit;p=Test</a></p>\n|,
                   "http://hikiwiki.org/ja/?c=edit;p=Test")
    assert_convert(%Q|<p><a href="http://hikiwiki.org/ja/?c=edit&amp;p=Test">| +
                   %Q|http://hikiwiki.org/ja/?c=edit&amp;p=Test</a></p>\n|,
                   "http://hikiwiki.org/ja/?c=edit&p=Test")
    assert_convert(%Q|<p><img src="/img.png" alt="img.png" /></p>\n|,
                   "http:/img.png")
    assert_convert(%Q|<p><img src="img.png" alt="img.png" /></p>\n|,
                   "http:img.png")
    assert_convert(%Q|<p><a href="%CB%EE">Tuna</a></p>\n|,
                   "[[Tuna|%CB%EE]]")
    assert_convert(%Q|<p><a href="&quot;&quot;">""</a></p>\n|,
                   '[[""]]')
    assert_convert(%Q|<p><a href="%22">%22</a></p>\n|,
                   "[[%22]]")
    assert_convert(%Q|<p><a href="&amp;">&amp;</a></p>\n|,
                   "[[&]]")
    assert_convert(%Q|<p><a href="aa">aa</a>bb<a href="cc">cc</a></p>\n|,
                   "[[aa]]bb[[cc]]")
  end

  it "wiki name" do
    assert_convert("<p><a href=\"WikiName\">WikiName</a></p>\n",
                   "WikiName")
    assert_convert("<p><a href=\"HogeRule1\">HogeRule1</a></p>\n",
                   "HogeRule1")

    assert_convert("<p><a href=\"WikiName1WikiName2\">WikiName1WikiName2</a></p>\n",
                   "WikiName1WikiName2")
    assert_convert("<p><a href=\"WikiName1\">WikiName1</a> " +
                      "<a href=\"WikiName2\">WikiName2</a></p>\n",
                   "WikiName1 WikiName2")

    assert_convert("<p>NOTWIKINAME</p>\n",
                   "NOTWIKINAME")
    assert_convert("<p>NOT_WIKI_NAME</p>\n",
                   "NOT_WIKI_NAME")
    assert_convert("<p>WikiNAME</p>\n",
                   "WikiNAME")
    assert_convert("<p>fooWikiNAME</p>\n",
                   "fooWikiNAME")

    assert_convert("<p>RSSPage</p>\n",
                   "RSSPage")
    assert_convert("<p><a href=\"RSSPageName\">RSSPageName</a></p>\n",
                   "RSSPageName")
  end

  it "not wiki name" do
    assert_convert("<p>WikiName</p>\n",
                   "^WikiName")
    assert_convert("<p>^<a href=\"WikiName\">WikiName</a></p>\n",
                   "^WikiName",
                   :use_not_wiki_name => false)
    assert_convert("<p>^WikiName</p>\n",
                   "^WikiName",
                   :use_wiki_name => false)
    assert_convert("<p>^WikiName</p>\n",
                   "^WikiName",
                   :use_wiki_name => false,
                   :use_not_wiki_name => false)
  end

  it "use wiki name option" do
    assert_convert("<p><a href=\"WikiName\">WikiName</a></p>\n",
                   "WikiName")
    assert_convert("<p>WikiName</p>\n",
                   "WikiName",
                   :use_wiki_name => false)
  end

  it "image link" do
    assert_convert(%Q|<p><img src="http://hikiwiki.org/img.png" alt="img.png" /></p>\n|,
                   "[[http://hikiwiki.org/img.png]]")
    assert_convert(%Q|<p><a href="http://hikiwiki.org/img.png">http://hikiwiki.org/img.png</a></p>\n|,
                   "[[http://hikiwiki.org/img.png]]",
                   :allow_bracket_inline_image => false)

    assert_convert(%Q|<p><img src="http://hikiwiki.org/img.png" alt="img" /></p>\n|,
                   "[[img|http://hikiwiki.org/img.png]]")
    assert_convert(%Q|<p><a href="http://hikiwiki.org/img.png">img</a></p>\n|,
                   "[[img|http://hikiwiki.org/img.png]]",
                   :allow_bracket_inline_image => false)
  end

  it "definition" do
    assert_convert("<dl>\n<dt>a</dt>\n<dd>b</dd>\n</dl>\n",
                   ":a:b")
    assert_convert("<dl>\n<dt>a</dt>\n<dd>b\n</dd>\n<dd>c</dd>\n</dl>\n",
                   ":a:b\n::c")
    assert_convert("<dl>\n<dt>a\\</dt>\n<dd>b:c</dd>\n</dl>\n",
                   ':a\:b:c')
    assert_convert("<dl>\n<dt>a</dt>\n<dd>b\\:c</dd>\n</dl>\n",
                   ':a:b\:c')
    assert_convert("<dl>\n<dt>a</dt>\n<dd>b:c</dd>\n</dl>\n",
                   ":a:b:c")
  end

  it "definition title only" do
    assert_convert("<dl>\n<dt>a</dt>\n</dl>\n",
                   ":a:")
  end

  it "definition description only" do
    assert_convert("<dl>\n<dd>b</dd>\n</dl>\n",
                   "::b")
  end

  it "definition with link" do
    assert_convert(%Q|<dl>\n<dt><a href="http://hikiwiki.org/">Hiki</a></dt>\n<dd>Website</dd>\n</dl>\n|,
                   ":[[Hiki|http://hikiwiki.org/]]:Website")
  end

  it "definition with modifier" do
    assert_convert(%Q|<dl>\n<dt><strong>foo</strong></dt>\n<dd>bar</dd>\n</dl>\n|,
                   ":'''foo''':bar")
  end

  it "table" do
    assert_convert(%Q|<table border=\"1\">\n<tr><td>a</td><td>b</td></tr>\n</table>\n|,
                   "||a||b")
    assert_convert(%Q|<table border=\"1\">\n<tr><td>a</td><td>b</td></tr>\n</table>\n|,
                   "||a||b||")
    assert_convert(%Q|<table border=\"1\">\n<tr><td>a</td><td>b</td></tr>\n</table>\n|,
                   "||a||b||")
    assert_convert(%Q|<table border=\"1\">\n<tr><td>a</td><td>b</td><td> </td></tr>\n</table>\n|,
                   "||a||b|| ")
    assert_convert(%Q|<table border=\"1\">\n<tr><th>a</th><td>b</td></tr>\n</table>\n|,
                   "||!a||b||")
    assert_convert(%Q|<table border=\"1\">\n<tr><td colspan=\"2\">1</td><td rowspan=\"2\">2\n</td></tr>\n<tr><td rowspan=\"2\">3</td><td>4\n</td></tr>\n<tr><td colspan=\"2\">5</td></tr>\n</table>\n|,
                   "||>1||^2\n||^3||4\n||>5")
    assert_convert(%Q|<table border=\"1\">\n<tr><td>a</td><td>b</td><td>c</td></tr>\n<tr><td></td><td></td><td></td></tr>\n<tr><td>d</td><td>e</td><td>f</td></tr>\n</table>\n|,
                   "||a||b||c||\n||||||||\n||d||e||f||")
  end

  it "table with modifier" do
    assert_convert("<table border=\"1\">\n<tr><td>'''</td><td>'''</td><td>bar</td></tr>\n</table>\n",
                   "||'''||'''||bar")
    assert_convert("<table border=\"1\">\n<tr><td>'''\\</td><td>'''</td><td>bar</td></tr>\n</table>\n",
                   "||'''\\||'''||bar")
  end

  it "modifier" do
    assert_convert("<p><strong>foo</strong></p>\n",
                   "'''foo'''")
    assert_convert("<p><em>foo</em></p>\n",
                   "''foo''")
    assert_convert("<p><del>foo</del></p>\n",
                   "==foo==")
    assert_convert("<p><em>foo==bar</em>baz==</p>\n",
                   "''foo==bar''baz==")
    assert_convert("<p><strong>foo</strong> and <strong>bar</strong></p>\n",
                   "'''foo''' and '''bar'''")
    assert_convert("<p><em>foo</em> and <em>bar</em></p>\n",
                   "''foo'' and ''bar''")
  end

  it "nested modifier" do
    assert_convert("<p><em><del>foo</del></em></p>\n",
                   "''==foo==''")
    assert_convert("<p><del><em>foo</em></del></p>\n",
                   "==''foo''==")
  end

  it "modifier and link" do
    assert_convert("<p><a href=\"http://hikiwiki.org/\"><strong>Hiki</strong></a></p>\n",
                   "[['''Hiki'''|http://hikiwiki.org/]]")
  end

  it "pre and plugin" do
    assert_convert(%Q|<pre>{{hoge}}</pre>\n|,
                   " {{hoge}}")
    assert_convert(%Q|<pre>{{hoge}}</pre>\n|,
                   "<<<\n{{hoge}}\n>>>")
    assert_convert("<div class=\"plugin\">{{foo\n 1}}</div>\n",
                   "{{foo\n 1}}")
  end

  it "plugin in modifier" do
    assert_convert("<p><strong><span class=\"plugin\">{{foo}}</span></strong></p>\n",
                   "'''{{foo}}'''")
  end

  if Object.const_defined?(:Syntax)

    it "syntax ruby" do
      assert_convert("<pre><span class=\"keyword\">class </span><span class=\"class\">A</span>\n  <span class=\"keyword\">def </span><span class=\"method\">foo</span><span class=\"punct\">(</span><span class=\"ident\">bar</span><span class=\"punct\">)</span>\n  <span class=\"keyword\">end</span>\n<span class=\"keyword\">end</span></pre>\n",
                     "<<< ruby\nclass A\n  def foo(bar)\n  end\nend\n>>>")
      assert_convert("<pre><span class=\"keyword\">class </span><span class=\"class\">A</span>\n  <span class=\"keyword\">def </span><span class=\"method\">foo</span><span class=\"punct\">(</span><span class=\"ident\">bar</span><span class=\"punct\">)</span>\n  <span class=\"keyword\">end</span>\n<span class=\"keyword\">end</span></pre>\n",
                     "<<< Ruby\nclass A\n  def foo(bar)\n  end\nend\n>>>")
      assert_convert("<pre><span class=\"punct\">'</span><span class=\"string\">a&lt;&quot;&gt;b</span><span class=\"punct\">'</span></pre>\n",
                     "<<< ruby\n'a<\">b'\n>>>")
    end
  end

  private
  def assert_convert(expected, markup, options={}, message=nil)
    HikiDoc.to_xhtml(markup, options).should == expected
  end

  def custom_valid_plugin_syntax?(code)
    eval("BEGIN {return true}\n#{code}", nil, "(plugin)", 0)
  rescue SyntaxError
    false
  end
end
