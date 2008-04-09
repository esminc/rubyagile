module ArticlesHelper
  include HikidocHelper

  def link_to_comments(article)
    if 0 < article.comment_count
      link_to("#{article.comment_count} Comments", article_path(article, :anchor => "comments"))
    else
      link_to("Not Yet Commented", article_path(article, :anchor => "comment_form"))
    end
  end

  def posted_on(time)
    time.to_date.to_s(:db)
  end
end
