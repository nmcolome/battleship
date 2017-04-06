require './lib/4_grid.rb'
require './lib/5_ships.rb'
require './lib/6_cell.rb'
require './lib/ship_setup.rb'
require './lib/coordinates_validation.rb'
require './lib/messages.rb'

require 'pry'

class User
  include ShipSetup
  include CoordinatesValidation
  include Messages

  attr_reader :board_size, :num_of_ships, :board, :user_shot_board
  
  def initialize(board_size, num_of_ships)
    @board_size = board_size
    @board = Grid.new(board_size)
    @user_shot_board = Grid.new(board_size)
    @num_of_ships = num_of_ships
  end

  def game_setup(board_size, num_of_ships)
    ships = ship_creation(@num_of_ships)
    input_validation(ships.count, ships, board)
  end

  def prompt_coordinates(num_of_ships, ships, board)
    ships.map do |ship|
      coordinate_input(ship)
      build_mid_squares(ship)
      until coord_validation(ship, board) != false
        coordinate_input(ship)
      end
    end
  end
  
  def input_validation(num_of_ships, ships, board)
    prompt_coordinates(num_of_ships, ships, board)
    until no_overlap?(ships) != false
      overlap_message
      prompt_coordinates(num_of_ships, ships, board)      
    end
    # binding.pry
    ship_placement(ships, board)
    puts "This is your ship layout"
    board.print_grid
    shot_prompt
  end

  def coordinate_input(ship)
    puts "Enter the starting and ending squares for the #{ship.type} (#{ship.magnitude}-units) ship:"
    input = gets.chomp
    coord = input.split(" ")
    if ship.cell.count == 0
      ship << Cell.new(coord.first)
      ship << Cell.new(coord.last)
    elsif
      ship.clear
      ship << Cell.new(coord.first)
      ship << Cell.new(coord.last)
    end
  end

  def shot_prompt
    puts "This is your shot board:"
    @user_shot_board.print_grid
    puts "Pick a target square by letter/number:"
    input = gets.chomp
    shot = Cell.new(input)
    player_shot_sequence(shot, @user_shot_board)    
  end

  def player_shot_sequence(shot, board)
    until validate_shot(shot, board) != false
      shot_prompt
    end
    shot
  end

end
