# This class contains the word to be guessed and the
# current state of the game. It has the functionality
# to print the hangman to the terminal and respond 
# to a player's guess appropriately.
class Computer

  attr_reader :round_finished, :guessed

  def initialize
    @word = choose_word
    @incorrect_letters = []
    @hangman = [
      "  O", "  O\n  \|", "  O\n /\|", "  O\n /\|\\", # Different iterations 
      "  O\n /\|\\\n /", "  O\n /\|\\\n / \\"         # of hangman drawing.
    ]
    @progress = ""
    @word.each_char { @progress << "_ " }
    @round_finished = false
    @guessed = false
  end

  # Reads in the 5desk.txt file and returns a random
  # 5-12 character string.
  def choose_word
    words = File.readlines("5desk.txt")
    words.map! { |word| word.chomp } # Remove newline characters from the file
    words.select! { |word| (word.size >= 5) && (word.size <= 12) }
    words.sample
  end

  # Takes in a string corresponding to a single letter
  # and updates instance variables and displays hangman.
  def respond_to_guess(letter)
    letter = letter.clone.downcase

    if @incorrect_letters.include?(letter) || @progress.include?(letter) || @progress.include?(letter.upcase)
      puts "You already guessed that letter!"
      puts ""
    elsif @word.include?(letter) || @word.include?(letter.upcase)
      update_progress(letter)
      unless @progress.include?("_")
        @round_finished = true
        @guessed = true
      end
    else
      @incorrect_letters << letter
      @round_finished = true if @incorrect_letters.size == 6
    end
    print_hangman
  end

  private

  # Prints the current state of the hangman, the
  # incorrect letters guessed, and the current state
  # of the guessed word.
  def print_hangman
    puts "------------------------------------------------"
    puts ""
    hangman_partial = @incorrect_letters.size - 1
    puts "#{@hangman[hangman_partial]}" if hangman_partial >= 0
    puts ""
    print "Incorrect letters: "
    @incorrect_letters.each { |letter| print "#{letter} " }
    print "\n\n"
    puts "#{@progress}"
    puts ""
  end

  # Takes in a letter and fills in all of the blanks.
  def update_progress(letter)
    case_insensitive = Regexp.new("[#{letter.upcase}#{letter}]")
    indicies = []
    indicies << @word.index(case_insensitive)
    until indicies.last.nil?
      indicies << @word.index(case_insensitive, indicies.last + 1) # Find the first occurence of
                                                                   # the case insensitive letter
                                                                   # starting from where the last 
                                                                   # occurence was found.
    end
    indicies.pop # Pop off the nil value
    indicies.each { |index| @progress[2*index] = @word[index] } # 2*index accounts for the spaces in   
                                                                # the @progress variable.
  end
end