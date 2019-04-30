class TacoDeli::Scrape

  def self.scrape_categories
		list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))
		categories = []
 		list.css("div.menu section.content.center-align.container.no-collapse li").each do |item|
			categories << item.attr("id")
		end
			categories.uniq.compact
	end


	def self.scrape
		list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))
    self.scrape_categories.each do |category|

 		list.css("##{category} ul.menu-items li.menu-item").each do |item|
        cat = category
				subcat = item.parent.parent.css("h3").text.strip
				name = item.css("h4").text.strip
				description = item.css("p").text.strip
				TacoDeli::Menu.new(cat, subcat, name, description)
 			end

 		end
  end


 end
