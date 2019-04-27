
class TacoDeli::Scrape

	def self.scraper(category)
		list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))
		menu_items = []
		
		if category == "daily"
			day = Date.today.strftime("%A").downcase

			list.search("h3.day-title.#{day}")[0].parent.css("li").each do |item|
				item_hash = {
					:name => item.css("h4").text.strip,
					:description => item.css("p").text.strip }
					menu_items << item_hash
				end


			else
				list.css("##{category} ul.menu-items li.menu-item").each do |item|
					item_hash = {
						:name => item.css("h4").text.strip,
						:description => item.css("p").text.strip }
						menu_items << item_hash
					end
				end
				menu_items
			end
		end
