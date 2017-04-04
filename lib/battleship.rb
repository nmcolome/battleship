require './lib/messages.rb'
require './lib/ships.rb'
require './lib/grid.rb'
require './lib/cell.rb'

class Battleship
  include Messages
  include ShipPlacement

  def initialize
    
  end

  def welcome_message
    puts welcome
    action = gets.chomp
      case action
    when "p" || "play"
      level_selection
    when "i" #|| "instructions"
      instructions
      puts
      puts
      welcome_message
    when "q" || "quit"
      quit
    end
  end

  def level_selection
    level
    selection = gets.chomp
      case selection
    when "a" || "advanced"
      game_setup(12,5)
    when "m" || "intermediate"
      game_setup(8,4)
    when "b" || "beginner"
      game_setup(4,2)
    end
  end

  def game_setup(board_size, num_of_ships)
    ships_types = ["patrol", "submarine", "battleship", "destroyer", "carrier"]    
    board = Grid.new(board_size)
    computer_ships = ships_types[0..num_of_ships - 1].map {|type| Ships.new(type)}
    users_ships = ships_types[0..num_of_ships - 1].map {|type| Ships.new(type)}
    computer_ship_placement(computer_ships)
  end

  def computer_ship_placement(computer_ships)
    computer_ships.each do |ship|
      random_comp_coordinates(ship.type, ship.magnitude)
      ship_placement_coordinates(ship.head, ship.tail)
      ship_setup(y_start, x_start, y_end, x_end)
    end
    board.print_grid    
  end
end