module KarekiEntriesHelper
	def replace_img_to_anchor(html)
		doc = Nokogiri::HTML::DocumentFragment.parse(html)

		doc.css("a[href^='http://www.flickr.com/photos/']", 'a.hatena-fotolife').each do |e|
			img = e.at('img')
			e.replace Nokogiri::HTML::DocumentFragment.parse("<a href='#{img[:src]}'>#{img[:title]}</a>")
		end

		doc.to_xhtml(:encoding => 'utf-8', :save_with => Nokogiri::XML::Node::SaveOptions::FORMAT)
	end
end
