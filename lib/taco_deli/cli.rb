require_relative './scraper'

class TacoDeli::CLI

  def call
    puts "Welcome to Taco Deli's Menu"
    @input = nil
    list_menu

  end

  def list_menu
    while @input != "exit"

      puts "┈┈┈┈╭╯╭╯╭╯┈┈┈┈┈"
      puts "┈┈┈╱▔▔▔▔▔╲▔╲┈┈┈"
      puts "┈┈╱┈╭╮┈╭╮┈╲╮╲┈┈"
      puts "┈┈▏┈▂▂▂▂▂┈▕╮▕┈┈"
      puts "┈┈▏┈╲▂▂▂╱┈▕╮▕┈┈"
      puts "┈┈╲▂▂▂▂▂▂▂▂╲╱┈┈"

      puts "Select a number to display the menu or type 'exit':"
      puts "1. Breakfast"
      puts "2. Lunch"
      puts "3. Sides"
      puts "4. Specials"
      puts "5. Drinks"
      puts "6. #{Date.today.strftime("%A")}'s Special"

      @input = gets.strip

      if @input == "1"
        @menu_array = TacoDeli::Scrape.scraper("breakfast")
      elsif @input == "2"
        @menu_array = TacoDeli::Scrape.scraper("lunch")
      elsif @input == "3"
        @menu_array = TacoDeli::Scrape.scraper("sides")
      elsif @input == "4"
        @menu_array = TacoDeli::Scrape.scraper("specials")
      elsif @input == "5"
        @menu_array = TacoDeli::Scrape.scraper("drinks")
      elsif @input == "6"
        @menu_array = TacoDeli::Scrape.scraper("daily")
      elsif @input.downcase == "exit"
        puts "Goodbye"
        break
      else
        puts "Invalid choice. Try again."
        list_menu
      end

      print_menu
    end
  end

  def print_menu
    @menu_array.each_with_index do |item, index|
      puts "\t#{index+1}. #{item[:name]}"
      puts "\t#{item[:description]}\n\n"
    end
  end


end
