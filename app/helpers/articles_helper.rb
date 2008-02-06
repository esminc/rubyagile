module ArticlesHelper
  def parse(text)
    HikiDoc.to_html(text, :level =>3)
  end

  def link_to_comments(article)
    comment_count = article.comments.size
    if 0 < comment_count
      link_to("#{comment_count} Comments", article_path(article, :anchor => "comments"))
    else
      link_to("Not Yet Commented", article_path(article, :anchor => "comment_form"))
    end
  end

  def posted_on(time)
    time.to_date.to_s(:db)
  end
end
