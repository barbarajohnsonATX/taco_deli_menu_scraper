class TacoDeli::Meal

  def self.find_categories
    categories = TacoDeli::Scrape.scrape_categories
    categories.uniq
  end


  def self.find_subcategories(meals)
    subcategories = []
    meals.each do |item|
        subcategories << item[:subcat] if item[:subcat] != ""
    end
    subcategories.uniq

  end

  def self.has_subcategories?(meals)
    if self.find_subcategories(meals).empty?
      false
    else
      true
    end
  end

  def self.find_by_subcategory(meals, category)
      filtered = meals.select do |item|
        item[:subcat] == category
       end
      filtered.uniq
  end

end
