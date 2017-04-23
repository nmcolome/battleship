require './lib/messages_module'

class Battleship
  include Messages

  def start
    welcome
    request_input
  end

  def selection(input)
    if input == "p" || input == "play"
      select_difficulty_level
    elsif input == "i" || input == "instructions"
      read_instructions
      request_input
    elsif input == "q" || input == "quit"
      quits
    end
  end

  def request_input
    request_action
    input = gets.chomp
    selection(input)
  end

  def select_difficulty_level
    difficulty_level
    input = gets.chomp
    game_setup(input)
  end

  def game_setup(input)
    if input == "b" || input == "beginner"
      create_grids(4)
      create_ships(2)
    elsif input == "i" || input == "intermediate"
      create_grids(8)
      create_ships(3)
    elsif input == "a" || input == "advanced"
      create_grids(12)
      create_ships(4)
    end
  end

  def create_grids(size)
    comp_arrangement = Board.new(size)
    comp_shots = Board.new(size)
    user_arrangement = Board.new(size)
    user_shots = Board.new(size)
  end

  def create_ships(number)
    ships = ["Destroyer", "Submarine", "Battleship", "Carrier"]
    ships = ships[0..number - 1]
    ships.map { |ship| Ship.new(ship) }
  end
end