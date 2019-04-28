class TacoDeli::CLI

  def call
    system "clear"
    @input = nil
    refresh_screen
    list_menu
  end

  def list_menu
    while @input != "exit"

      #print main menu based on scraped categories (based on 'id')
      categories = TacoDeli::Meal.find_categories
      print_main_menu(categories)
      input = gets.strip.downcase

      #scrape menu items for selected category
      if input.to_i.between?(1, categories.length-1)
        @menu_array = TacoDeli::Scrape.scrape(categories[input.to_i-1])

      #check if last option is selected, then scrape the daily special
      elsif input.to_i == categories.length
        @menu_array = TacoDeli::Scrape.scrape_daily_special(today)

      elsif input == "exit"
        goodbye
        break

      else
        invalid
        list_menu
      end

      (TacoDeli::Meal.has_subcategories?(@menu_array) ?
          print_subcategory_menu(@menu_array) :
          print_selected_menu(@menu_array))

    end #end of while loop
  end


  def refresh_screen
    system "clear"
    puts "\t\tWelcome to Taco Deli's Menu"
  end

  def print_banner
    puts "\t\t┈┈┈┈╭╯╭╯╭╯┈┈┈┈┈"
    puts "\t\t┈┈┈╱▔▔▔▔▔╲▔╲┈┈┈"
    puts "\t\t┈┈╱┈╭╮┈╭╮┈╲╮╲┈┈"
    puts "\t\t┈┈▏┈▂▂▂▂▂┈▕╮▕┈┈"
    puts "\t\t┈┈▏┈╲▂▂▂╱┈▕╮▕┈┈"
    puts "\t\t┈┈╲▂▂▂▂▂▂▂▂╲╱┈┈"
    puts ""
  end

  def print_main_menu(items)
    #find main categories: breakfast, lunch, sides, etc.
    print_banner

    #create options list based on categories found
    list_main_menu_options(items)
  end

  def list_main_menu_options(items)
    puts "\t\tSelect a number to display the menu or type 'exit':"

    items[0..-2].each_with_index do |item, index|
      puts "\t\t#{index+1}. #{item.downcase}"
    end

    #last item is daily special based on today's day
    puts "\t\t#{items.length}. daily special: #{today}"
  end

  def today
    Date.today.strftime("%A").downcase
  end

  def invalid
    puts "\t\tInvalid choice. Try again."
  end

  def goodbye
    puts "\t\tGoodbye"
  end

  def print_subcategory_menu(items)
    @input = nil

    subcategories = TacoDeli::Meal.find_subcategories(items)
    if subcategories.length > 1
      puts "\t\tSelect from the subcategory or type 'back' to return to the main menu:"
      print_options(subcategories)

      @input = gets.strip
      if @input.downcase == "back"
        list_menu
      elsif !@input.to_i.between?(1, subcategories.length)
        invalid
        print_subcategory_menu(items)
      else
        list = TacoDeli::Meal.find_by_subcategory(items, subcategories[@input.to_i-1])
        print_selected_menu(list)
      end

    else
      print_selected_menu(items)
    end

   end

  def print_options(items)
    items.each_with_index do |item, index|
      puts "\t\t#{index+1}. #{item.downcase}"
    end
  end

  def print_selected_menu(items)
    puts "\t#{items.first[:subcat]} Menu"
    items.each_with_index do |item, index|
      puts "\t#{index+1}. #{item[:name]}"
      puts "\t#{item[:description]}\n\n"
    end
  end

end
