class WikiEngine
  def initialize(options={})
    @amazon_associate = options[:amazon_associate]
  end

  def render_text(text)
    hikified = HikiDoc.to_html(text, :level =>3)
    replace_plugin(hikified)
  end

  def replace_by_unresolved_wikiname(html)
    # TODO http://で始まる文字列は外す処理を入れること
    wikinames = html.grep(/<a href="(.+)">(.+)<\/a>/o) { |item|
      $1 if $1 == $2
    }.uniq
    pages = Page.find(:all).map { |page| page.name }
    wikinames -= pages
    wikinames.each { |wikiname|
      html.gsub!(/<a href="#{wikiname}">#{wikiname}<\/a>/,
        %Q|#{wikiname}<a href="#{wikiname}/new">?</a>|)
    }
    html
  end

  private
  PLUGIN_REGEXP = %r!<div class="plugin">\{\{(.+)\}\}</div>!m
  def replace_plugin(hikified_html)
    hikified_html.gsub!(PLUGIN_REGEXP) do |body|
      CGI.unescapeHTML($1)[1...-1]
    end
    replace_by_unresolved_wikiname(hikified_html)
  end
end
