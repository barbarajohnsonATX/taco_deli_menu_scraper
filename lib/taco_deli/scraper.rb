class TacoDeli::Scrape

  def self.scrape_categories
		list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))
		categories = []
 		list.css("div.menu section.content.center-align.container.no-collapse li").each do |item|
			categories << item.attr("id")
		end
			categories.uniq.compact
	end

	def self.scrape_daily_special(day)
		list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))
		menu_items = []

		list.search("h3.day-title.#{day}")[0].parent.css("li").each do |item|
			item_hash = {
				:subcat => item.parent.parent.css("h3").text.strip,
				:name => item.css("h4").text.strip,
				:description => item.css("p").text.strip }
				menu_items << item_hash
			end
			menu_items
 	end


	def self.scrape(category)
		list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))
		menu_items = []
 		list.css("##{category} ul.menu-items li.menu-item").each do |item|
			item_hash = {
				:subcat => item.parent.parent.css("h3").text.strip,
				:name => item.css("h4").text.strip,
				:description => item.css("p").text.strip }
				menu_items << item_hash
			end
			menu_items
 		end

end
