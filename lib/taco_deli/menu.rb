class TacoDeli::Menu
  attr_accessor   :category, :subcategory, :name, :description

  @@all = []

  def initialize(category, subcategory, name, description)
    @category = category
    @subcategory = subcategory
    @name = name
    @description = description
    save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

  #generte a list of all categories (breakfast, lunch, ...)
  def self.find_categories
    self.all.collect { |item| item.category }.uniq
  end

  #generate a list of a category's subcategories (lunch: chicken, beef, etc)
  def self.find_subcategories(cat)
    list = []
    self.all.select do |item|
      if item.category == cat && item.subcategory != ""
        list << item.subcategory
      end
    end
    list.uniq
  end

  #generate list of items from a category
  def self.find_by_category(cat)
    list = self.all.select { |item| item.category == cat }
  end

  #generate list of itmes from a subcategory
  def self.find_by_subcategory(subcat)
    list = self.all.select { |item| item.subcategory == subcat }
  end

 #check if a category has a subcategory
  def self.category_has_subcategories?(cat)
    test = self.all.select { |item| item.category == cat }
    (test.first.subcategory == "" ? returnval = false : returnval = true)
    return returnval
  end

end
