module DashboardHelper
  def render_status_for(article)
    (article.published? ? "公開" : "草稿")
  end
end
