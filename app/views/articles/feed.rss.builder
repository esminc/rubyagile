xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ruby x Agile"
    xml.description "Rubyでアジャイルなソフトウェア開発を実現する永和システムマネジメントのWebサイト"
    xml.link articles_url

    @articles.each do |article|
      xml.item do
        xml.title article.title
        xml.description parse_article(article)
        xml.pubDate article.updated_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
