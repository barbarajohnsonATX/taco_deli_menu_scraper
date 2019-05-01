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

      #Find all categories and list them
      categories = TacoDeli::Menu.find_categories
      list_options(categories)

      @input = gets.strip.downcase

      if @input.to_i.between?(1, categories.length)

        #Check if the selected category has subcategories
        #If so, list the subcategory menu
        if TacoDeli::Menu.category_has_subcategories?(categories[@input.to_i-1])
          ret = subcategories_menu(categories[@input.to_i-1])
        else
          list_category_items(categories[@input.to_i-1])

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
    puts "You want some tacos? Which menu would you like to see?"
    puts "Enter the number or type 'exit.'"
    puts ""
    puts "\t\t┈┈┈┈╭╯╭╯╭╯┈┈┈┈┈".red
    puts "\t\t┈┈┈╱▔▔▔▔▔╲▔╲┈┈┈".red
    puts "\t\t┈┈╱┈╭╮┈╭╮┈╲╮╲┈┈".red
    puts "\t\t┈┈▏┈▂▂▂▂▂┈▕╮▕┈┈".red
    puts "\t\t┈┈▏┈╲▂▂▂╱┈▕╮▕┈┈".red
    puts "\t\t┈┈╲▂▂▂▂▂▂▂▂╲╱┈┈".red
    puts ""
  end

  def invalid
    puts "Sorry, that's not a valid option. Try again.".blue
  end

  def goodbye
    puts "Buh bye.".blue
  end

  def subcategories_menu(cat)
    puts ""
    puts "#{cat.capitalize} Menu "

    #Find all subcategory options
    subcat_list = list_subcategory_options(cat)

    @input = gets.strip.downcase

    #Check if input is valid and list subcategories items
    if @input.to_i.between?(1, subcat_list.length)
      list_subcategory_items(subcat_list[@input.to_i-1])

    elsif @input == "back"
      returnval = "back"

    elsif @input == "exit"
      retval = "exit"

    else
      invalid
      subcategories_menu(cat)
    end

    return returnval
  end


  def list_items(list)
    list.each_with_index do |item, index|
      puts "#{index+1}. " + "#{item.category.upcase}".blue + " : #{item.subcategory.capitalize} ".green + ": #{item.name}".red
      puts "#{item.description}"
      puts ""
    end
  end


  def list_options(list)
    list.each_with_index do |item, index|
      puts "#{index+1}. #{item.capitalize}"
    end
  end

  #lists category (ex: breakfast) items
  def list_category_items(cat)
    list_items(TacoDeli::Menu.list_by_category(cat))
  end

 #lists subcategory (ex: chicken) items
 def list_subcategory_items(subcat)
    list_items(TacoDeli::Menu.list_by_subcategory(subcat))
 end

 def list_subcategory_options(cat)
   list_options(TacoDeli::Menu.find_subcategories(cat))
 end


end
