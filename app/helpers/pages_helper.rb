module PagesHelper
  def parse_page(page)
    wiki_engine = WikiEngine.new(:amazon_associate => page.user.amazon_associate)
    wiki_engine.render_text(page.content)
  end
end