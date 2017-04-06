require './lib/4_grid.rb'
require './lib/5_ships.rb'
require './lib/6_cell.rb'
require './lib/ship_setup.rb'
require './lib/coordinates_validation.rb'

require 'pry'

class Computer
  include ShipSetup
  include CoordinatesValidation

  attr_reader :board_size, :num_of_ships, :comp_board
  
  def initialize(board_size, num_of_ships)
    @board_size = board_size
    @comp_board = Grid.new(board_size)    
    @num_of_ships = num_of_ships
  end

  def comp_ship_coordenates(num_of_ships, board_size)
    ships = ship_creation(num_of_ships)
    coord_per_ship(ships)
    while no_overlap?(ships) == false
      coord_per_ship(ships)
    end
    ship_placement(ships, comp_board)
    comp_board.print_grid
  end
    
  def coord_per_ship(ships)
    ships_with_coord = ships.map do |ship|
      ship.clear
      random_coordinates(ship, ship.magnitude, board_size)
    end
  end

  def random_coordinates(ship, magnitude, board_size)
    position = rand(2)
    if position == 0 #horizontal
      row = rand(board_size)
      column = rand(board_size - magnitude)
      ship << Cell.new("#{ABC[row]}#{column + 1}")
      ship << Cell.new("#{ABC[row]}#{column + magnitude}")
    else #vertical
      row = rand(board_size - magnitude + 1)
      column = rand(board_size)
      ship << Cell.new("#{ABC[row]}#{column + 1}")
      ship << Cell.new("#{ABC[row + magnitude - 1]}#{column + 1}")
    end
    
    build_mid_squares(ship)
  end

  def shot_sequence(board_size)
    random_shot = rand_shot(board_size)
    while repeated_shot(random_shot) == false
      random_shot = rand_shot(board_size)
    end
    random_shot
  end

  def rand_shot(board_size)
    row = rand(board_size)
    column = rand(board_size)
    shot = Cell.new("#{ABC[row]}#{column}")
  end
end
