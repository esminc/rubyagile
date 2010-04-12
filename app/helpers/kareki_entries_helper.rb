module KarekiEntriesHelper
  def replace_img_to_anchor(html)
    doc = Nokogiri::HTML::DocumentFragment.parse(html)

    doc.css("a[href^='http://www.flickr.com/photos/']", 'a.hatena-fotolife').
      select {|a| a.at('img') }.
      each { |a| a.content = a.at('img')[:title] }

    doc.to_xhtml(:encoding => 'utf-8', :save_with => Nokogiri::XML::Node::SaveOptions::FORMAT)
  end
end
