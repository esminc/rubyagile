module ArticlesHelper
  def parse_article(article)
    wiki_engine = WikiEngine.new(:amazon_associate => article.user.amazon_associate)
    wiki_engine.render_text(article.body)
  end

  def link_to_comments(article)
    if 0 < article.comment_count
      link_to("#{article.comment_count} Comments", article_path(article, :anchor => "comments"))
    else
      link_to(I18n.t("app.articles.no_comments", :default => "Not Yet Commented"), article_path(article, :anchor => "comment_form"))
    end
  end

  def posted_on(time)
    time.to_date.to_s(:db)
  end

end
