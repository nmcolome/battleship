require './lib/messages.rb'
require './lib/ship_placement.rb'

require './lib/ships.rb'
require './lib/grid.rb'
require './lib/cell.rb'
require 'pry'

class Battleship
  include Messages
  include ShipPlacement

  def welcome_message
    puts welcome
    action = gets.chomp
      case action
    when "p" || "play"
      level_selection
    when "i" || "instructions"
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
      message_setup(12,5)
    when "m" || "intermediate"
      game_setup(8,4)
      message_setup(8,4)
    when "b" || "beginner"
      game_setup(4,2)
      message_setup(4,2)
    end
  end

  def game_setup(board_size, num_of_ships)
    ships_types = ["patrol", "submarine", "destroyer", "battleship", "carrier"]    
    comp_board = Grid.new(board_size)
    user_board = Grid.new(board_size)
    computer_ships = ships_types[0..num_of_ships - 1].map {|type| Ships.new(type)}
    user_ships = ships_types[0..num_of_ships - 1].map {|type| Ships.new(type)}
    computer_validation(computer_ships, comp_board)
  end

  def computer_layout
  end
  



  def computer_validation(computer_ships, comp_board) #pendiente de validar q no haya overlap
    comp_board_size = comp_board.board_size
    #inicio de loop q no se como hacer
    comp_ship_coord = computer_ships.map do |ship|
      random_comp_coordinates(ship, ship.magnitude, comp_board_size)
    end
    # computer_ships.map do |ship|
    #   coordinates = []
    #   coordinates << ship.coordinates(0) 
    #   coordinates << ship.coordinates(1)
    #   end
    # if coordinates.uniq! !=nil
    #   comp_ship_coord = computer_ships.map do |ship|
    #   random_comp_coordinates(ship, ship.magnitude, comp_board_size)
    # end
    # end
    computer_ships.map do |ship|
      ship_setup(ship, comp_board)
    end
    p comp_board.print_grid #eliminar
  end

  def random_comp_coordinates(ship, magnitude, board_size)
    position = rand(2)
    if position == 0 #horizontal
      row = rand(board_size)
      column = rand(board_size - magnitude + 1)
      ship << Cell.new("#{row}#{column}")
      ship << Cell.new("#{row}#{column + magnitude - 1}")
    else #vertical
      row = rand(board_size - magnitude + 1)
      column = rand(board_size)
      ship << Cell.new("#{row}#{column}")
      ship << Cell.new("#{row + magnitude - 1}#{column}")
    end
  end

  # def ship_placement_coordinates(head, tail)
  #   starting = head.split(//)
  #   ending = tail.split(//)
  #   y_start = columns_key.index(starting[0])
  #   x_start = rows_key.index(starting[1])
  #   y_end = columns_key.index(ending[0])
  #   x_end = rows_key.index(ending[1])
  #   coordinates = [y_start, x_start, y_end, x_end]
  # end

  def ship_setup(ship, player_board)
    if ship.row(0) == ship.row(1)
      player_board.grid[ship.row(0).to_i][ship.column(0).to_i] = "<"
      player_board.grid[ship.row(1).to_i][ship.column(1).to_i] = ">"
      interior = ship.column(0).next.to_i
      until interior == ship.column(1).to_i
        player_board.grid[ship.row(0).to_i][interior] = "*"
        interior += 1
      end
    else
      player_board.grid[ship.row(0).to_i][ship.column(0).to_i] = "^"
      player_board.grid[ship.row(1).to_i][ship.column(1).to_i] = "v"
      interior_row = ship.row(0).next.to_i
      until interior_row == ship.row(1).to_i
        player_board.grid[interior_row][ship.column(0).to_i] = "*"
        interior_row += 1
      end
    end
  end

end