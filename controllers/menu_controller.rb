require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    #Print menu to terminal and get user input
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    puts "6 - View Entry Number (n)"
    print "Enter your selection: "
    #Capture user input with 'gets' and convert selection to integer
    selection = gets.to_i

    #Case for user 'selection'
    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      puts "Goodbye!"
      exit(0)
    when 6
      system "clear"
      view_entry_number
      main_menu
    else
      system "clear"
      puts "Sorry that is not a valid input"
      main_menu
    end
  end

  def view_entry_number
    print "Please provide the number of the entry you wish to view: "
    selection = gets.chomp.to_i

    if address_book.entries[selection]
      puts address_book.entries[selection]
      puts "Please press enter to return to the main menu"
      gets.chomp
      system "clear"
    else
      puts "Sorry, entry #{selection}, does not exist. Please try again and provide a valid entry number."
      view_entry_number
    end
  end

  def view_all_entries
    #Iterate through each entry in address_book
    address_book.entries.each do |e|
      system "clear"
      puts e.to_s
      entry_submenu(e)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    system "clear"
    puts "New AddressBloc entry"
    print "Name: "
    name = gets.chomp
    print "Phone Number: "
    phone_number = gets.chomp
    print "Email: "
    email = gets.chomp
    #Add user entered data as entry in address_book
    address_book.add_entry(name, phone_number, email)
    system "clear"
    puts "New entry created."
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
    #Print submenu to terminal for user
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    selection = gets.chomp

    case selection
    when n
    when d
    when e
    when m
      system "clear"
      main_menu
    else
      system "clear"
      puts "Sorry, #{selection}, is not a valid input."
      entry_submenu(entry)
    end
  end

end
