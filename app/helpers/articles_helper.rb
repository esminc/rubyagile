module ArticlesHelper
  def parse(text)
    HikiDoc.to_html(text, :level =>3)
  end
end
