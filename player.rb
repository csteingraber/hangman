# This class contains the functionality
# to prompt the user of the game for input
# and to sanitize that input.
class Player

  # Prompts the user for a single case-insensitive 
  # letter and verifies that it is only one character
  # and within the alphabet.
  def prompt
    puts "Choose a letter:"
    puts ""
    letter = gets.strip
    puts ""
    until letter.size == 1 && letter =~ /[A-Za-z]/
      puts "You can only choose 1 letter in the alphabet at a time."
      puts ""
      letter = gets.strip
      puts ""
    end
    letter
  end
end