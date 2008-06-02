# -*- coding: utf-8 -*-
module DashboardHelper
  def render_status_for(article)
    (article.publishing? ? "公開" : "草稿")
  end
end
