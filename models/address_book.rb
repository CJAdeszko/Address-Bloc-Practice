require_relative 'entry'
require 'csv'

class AddressBook
  attr_reader :entries

  def initialize
    @entries = []
  end

  def add_entry(name, phone_number, email)
    index = 0
    entries.each do |entry|
      if name < entry.name
        break
      end
      index += 1
    end
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash['name'], row_hash['phone_number'], row_hash['email'])
    end
  end

  def binary_search(name)
    #Save the left most item in array in lower and the right most in upper
    lower = 0
    upper = entries.length - 1

    while lower <= upper
      #Find the middle index of the array and save the name in 'mid_name'
      mid = (lower + upper) / 2
      mid_name = entries[mid].name
      #Compare the name we are searching for to the mid_name
      if name == mid_name
        return entries[mid]   #If name == mid_name, we found the correct entry
      elsif name < mid_name
        upper = mid - 1   #If name comes before mid_name, set the upper limit to the mid index - 1
      elsif name > mid_name
        lower = mid + 1   #If name comes after mid_name, set the lower limit to the mid index + 1
      end
    end
    return nil    #If no match is found in the array, return nil
  end

  def demolish_entries
    @entries = []
  end
end
