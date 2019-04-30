class TacoDeli::CLI

  def call
    system "clear"
    @input = nil
    TacoDeli::Scrape.scrape
    start
  end

  def start
    while @input != "exit"
      print_banner
      categories = TacoDeli::Menu.categories_menu

      @input = gets.strip.downcase

      if @input.to_i.between?(1, categories.length)

        if TacoDeli::Menu.category_has_subcategories?(categories[@input.to_i-1])
          ret = subcategories_menu(categories[@input.to_i-1])
        else
          TacoDeli::Menu.print_items_by_category(categories[@input.to_i-1])
        end

      elsif @input == "exit" || ret == "exit"
        goodbye
        break

      elsif ret == "back"
        start

      else
        invalid
        start
      end

    end #end of while loop
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

  def invalid
    puts "Invalid choice. Try again."
  end

  def goodbye
    puts "Goodbye."
  end

  def subcategories_menu(cat)
    returnval = nil
    subcat_list = TacoDeli::Menu.print_subcategories_of(cat)
    @input = gets.strip.downcase
    if @input.to_i.between?(1, subcat_list.length)
      TacoDeli::Menu.print_items_by_subcategory(subcat_list[@input.to_i-1])
    elsif @input == "back"
      returnval = "back"
    elsif @input == "exit"
      retval = "exit"
    else
      invalid
      subcategory_menu(cat)
    end
    return returnval
  end

end
