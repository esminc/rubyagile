class WikiEngine
  def initialize(options={})
    @amazon_associate = options[:amazon_associate]
  end

  def render_text(text)
    hikified = HikiDoc.to_html(text, :level =>3)
    replace_plugin(hikified)
  end

  private
  PLUGIN_REGEXP = %r!<div class="plugin">\{\{(.+)\}\}</div>!m
  def replace_plugin(hikified_html)
    hikified_html.gsub!(PLUGIN_REGEXP) do |body|
      CGI.unescapeHTML($1)[1...-1]
    end
    hikified_html
  end
end
