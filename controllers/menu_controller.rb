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
    puts "6 - Delete all entries"
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
      address_book.demolish_entries
      puts "All entries deleted."
      main_menu
    else
      system "clear"
      puts "Sorry that is not a valid input"
      main_menu
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

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted."
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    puts "Updated entry: "
    puts entry
  end

  def search_entries
    print "Search by name: "
    name = gets.chomp
    match = address_book.binary_search(name)
    system "clear"
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}."
    end
  end

  def read_csv
    print "Enter a CSV file to import: "
    file_name = gets.chomp
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}."
    rescue
      puts "#{file_name} is not a vaild CSV file. Please enter the name of a valid CSV file."
      read_csv
    end
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
      delete_entry(entry)
    when e
      edit_entry(entry)
      entry_submenu(entry)
    when m
      system "clear"
      main_menu
    else
      system "clear"
      puts "Sorry, #{selection}, is not a valid input."
      entry_submenu(entry)
    end
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit entry"
    puts "m - return to main menu"
    selection = gets.chomp
    case selection
    when d
      system "clear"
      delete_entry(entry)
      main_menu
    when e
      edit_entry(entry)
      system "clear"
      main_menu
    when m
      system "clear"
      main_menu
    else
      system "clear"
      puts "Sorry, #{selection} is not a a valid selection."
      puts entry.to_s
      search_submenu(entry)
    end
  end

end
