module ArticlesHelper
  def parse_article(article)
    wiki_engine = WikiEngine.new(:amazon_associate => article.user.amazon_associate)
    wiki_engine.render_text(article.body)
  end

  def link_to_comments(article)
    link_to 'View Comments', article_path(article, :anchor => 'disqus_thread')
  end

  def posted_on(time)
    time.to_date.to_s(:db)
  end
end
