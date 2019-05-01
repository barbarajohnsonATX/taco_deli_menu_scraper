class TacoDeli::Scrape

  def self.scrape
    list = Nokogiri::HTML(open("https://www.tacodeli.com/menu/"))

    list.css("ul.menu-items li.menu-item").each_with_index do |item, index|
      category = item.parent.parent.parent.parent.parent.parent[:id]
      subcat = item.parent.parent.css("h3").text.strip
      name = item.css("h4").text.strip
      description = item.css("p").text.strip
      TacoDeli::Menu.new(category, subcat, name, description)
    end
  end
 end
