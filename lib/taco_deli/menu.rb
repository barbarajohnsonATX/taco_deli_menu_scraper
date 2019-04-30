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

  def self.find_categories
    categories = @@all.collect { |item| item.category }
    categories.uniq
  end

  def self.categories_menu
    categories = self.find_categories.each_with_index do |item, index|
      puts "#{index+1}. #{item}"
    end
    categories
  end

  def self.list_subcategories_menu(subcat)
     subcat.each_with_index do |item, index|
      puts "#{index+1}. #{item}"
    end
  end

  def self.print_subcategories_of(cat)
    list = []
    @@all.select do |item|
      if item.category == cat && item.subcategory != ""
        list << item.subcategory
      end
    end
     self.list_subcategories_menu(list.uniq)
     list.uniq
  end

  def self.print_items_by_category(cat)
    list = self.list_by_category(cat)
    self.print_items(list)
  end

  def self.list_by_category(cat)
    list = @@all.select { |item| item.category == cat }
  end

  def self.print_items(list)
    list.each_with_index do |item, index|
      puts "#{index+1}. #{item.category} : #{item.subcategory} #{item.name}"
      puts "#{item.description}"
      puts ""
    end
  end

  def self.list_by_subcategory(subcat)
    list = @@all.select { |item| item.subcategory == subcat }
  end

  def self.print_items_by_subcategory(subcat)
    results = self.list_by_subcategory(subcat)
    self.print_items(results)
  end

  def self.category_has_subcategories?(cat)
    returnval = nil
    test = @@all.select { |item| item.category == cat }
     if test.first.subcategory == nil || test.first.subcategory == ""
       returnval = false
    else
      returnval = true
    end
     return returnval
  end

end
