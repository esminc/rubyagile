# -*- coding: utf-8 -*-
class WikiEngine
  def initialize(options={})
    @amazon_associate = options[:amazon_associate]
  end

  def render_text(text)
    hikified = HikiDoc.to_html(text, :level =>3)
    replace_plugin(hikified)
  end

  def replace_text(html)
    # TODO http://で始まる文字列は外す処理を入れること
    wikinames = find_wikiname_in(html)
    add_prefix_path(html, wikinames)
    replace_by_unresolved_wikiname(html, wikinames)
    html
  end

  private
  PLUGIN_REGEXP = %r!<div class="plugin">\{\{([^\}]+?)\}\}</div>!m
  def replace_plugin(hikified_html)
    hikified_html.gsub!(PLUGIN_REGEXP) do |body|
      CGI.unescapeHTML($1)[1...-1]
    end
    hikified_html.gsub!(/\{\{["']/, '')
    hikified_html.gsub!(/["']\}\}/, '')
    if $1
      replace_plugin(hikified_html)
    end
    replace_text(hikified_html)
  end

  def find_wikiname_in(page)
    page.lines.grep(%r|<a href="([^http://].+)">(.+)</a>|o) { |item|
      $1 if $1 == $2
    }.uniq
  end

  PREFIX_PATH = "/pages"
  def add_prefix_path(html, wikinames)
    wikinames.each { |wikiname|
      html.gsub!(%r|<a href="#{wikiname}">#{wikiname}</a>|,
        %Q|<a href="#{PREFIX_PATH}/#{wikiname}">#{wikiname}</a>|)
    }
  end

  def replace_by_unresolved_wikiname(html, wikinames)
    unresolved_wikinames = unresolved_wikinames(wikinames)
    unresolved_wikinames.each { |wikiname|
      html.gsub!(%r|<a href="/pages/#{wikiname}">#{wikiname}</a>|,
        %Q|#{wikiname}<a href="/pages/new?page_name=#{wikiname}">?</a>|)
    }
  end

  def unresolved_wikinames(wikinames)
    existing_page_names = Page.find(:all).map { |page| page.name }
    wikinames -= existing_page_names
  end
end
