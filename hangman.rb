require "./computer"
require "./player"
require "yaml"

# This class acts as a container for
# the Computer and Player class and 
# mediates gameplay between the two.
# This class also implements the save 
# and load functionality.
class Hangman
  
  # Creates a new Computer and Player Object
  # and starts the game between the two.
  def initialize
    @computer = Computer.new
    @player = Player.new
    start
  end

  # Starts a loop of player prompting and
  # computer responses until the word is
  # guessed or the hangman is drawn.
  def start
    load
    until @computer.round_finished
      save
      @computer.respond_to_guess(@player.prompt)
    end

    if @computer.guessed
      puts "You won!"
    else
      puts "You lost!"
    end
  end 

  # This asks the user if they want to save
  # the game and will write the contents of
  # @computer to YAML.
  def save
    puts "Would you like to save your progress? (y/n)"
    puts ""
    response = gets.strip.downcase
    puts ""
    if response == "y"
      File.open("saves.yaml", "w") do |file|
        file.puts YAML::dump(@computer)
      end
      puts "Your game has been saved!"
      puts ""
    else
      puts "Lets just keep playing then!"
      puts ""
    end
  end

  # This asks the user if they want to load a previous
  # game and loads in the old values of @computer from 
  # the saves.yaml file.
  def load
    puts "Would you like to load your previous game? (y/n)"
    puts ""
    response = gets.strip.downcase
    puts ""
    if response == "y" && File.exist?("saves.yaml")
      save = File.read("saves.yaml")
      @computer = YAML::load(save)
      puts "Your game has been loaded!"
      puts ""
    else
      puts "New game created!"
      puts ""
    end
  end
end

Hangman.new