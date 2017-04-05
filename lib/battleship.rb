require './lib/messages.rb'
require './lib/ship_placement.rb'
require './lib/ships.rb'
require './lib/grid.rb'
require './lib/cell.rb'
require 'pry'

class Battleship
  include Messages
  include ShipPlacement

  attr_reader :comp_board, :user_board, :user_shot_board, :comp_shot_board

  def initialize
    @comp_board = comp_board
    @user_board = user_board
    @user_shot_board = user_shot_board
    @user_shot_board = user_shot_board
  end

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
      computer_setup(12,5)
      message_setup(12,5)
    when "m" || "intermediate"
      computer_setup(8,4)
      message_setup(8,4)
    when "b" || "beginner"
      computer_setup(4,2)
      message_setup(4,2)
    end
  end

  def user_setup(board_size, num_of_ships)
    user_ships = ship_creation(num_of_ships)
    @user_board = Grid.new(board_size)
    prompt_coordinates(user_ships.count, user_ships, @user_board)
  end
  
  def prompt_coordinates(num_of_ships, ships, user_board)
    ships.map do |ship|
      # binding.pry
      coordinate_input(ship)
      until coord_validation(ship, @user_board) != false
        coordinate_input(ship)
      end
    end
      ship_placement(ships, @user_board)
      @user_board.print_grid
      player_shot_sequence(user_board.board_size)
  end

  def coordinate_input(ship)
    puts "Enter the starting and ending squares for the #{ship.type} (#{ship.magnitude}-units) ship:"
    input = gets.chomp
    user_coord = input.split(" ")
    if ship.cell.count == 0
      ship << Cell.new(user_coord.first)
      ship << Cell.new(user_coord.last)
    elsif
      ship.clear
      ship << Cell.new(user_coord.first)
      ship << Cell.new(user_coord.last)
    end
  end

  def ship_creation(num_of_ships)
    ships_types = ["patrol", "submarine", "destroyer", "battleship", "carrier"]    
    ships_types[0..num_of_ships - 1].map {|type| Ships.new(type)}    
  end

  def computer_setup(board_size, num_of_ships)
    computer_ships = ship_creation(num_of_ships)
    @comp_board = Grid.new(board_size)    
    computer_placement(computer_ships, @comp_board)
  end

  def build_mid_squares(ship)
    if ship.row(0) == ship.row(1) #is horizontal
      middle = ship.column(0).next
      until middle == ship.column(1)
        position = 1
        ship.insert(position, Cell.new("#{[ship.row(0)]}#{[middle]}"))
        middle += 1
        position +=1
      end
    else
      middle = ship.row(0).next
      until middle == ship.row(1)
        position = 1
        ship.insert(position, Cell.new("#{[middle]}#{[ship.column(0)]}"))
        middle += 1
        position +=1
      end
    end
  end
  
  def ship_placement(ship, board) # previous ship setup
      board.grid[ship.row(0)][ship.column(0)] = "<"
      board.grid[ship.row(1)][ship.column(1)] = ">"
  end

  def coord_validation(ship, board)
    binding.pry
    c_val = []
    c_val << false if coordinates_comply?(ship, board) == false
    c_val << false if placement_complies?(ship) == false
    c_val << false if overlaps?(ship, board) == false
    c_val << false if squares_are_first_and_last(ship) == false
    c_val = false if c_val.include?(false)
  end

  def coordinates_comply?(ship, board) #is outside of board
    size = board.board_size
    index = ship.cell.count - 1
    rows = rows_key(size - 1)
    columns = columns_key(size)

    c_comply = []
    c_comply = (0..index).map do |idx|
      rows.include?(ALPHA[ship.row(idx)]) && columns.include?(NUMBERS[ship.column(idx) - 1])
    end
    if c_comply.include?(false)
      puts "Ships cannot wrap around the board. Please assign new coordinates"
      c_comply = false      
    end 
  end

  def placement_complies?(ship)
    last = ship.cell.count - 1
    if ship.row(0) == ship.row(last) #is horizontal
      p_comply = true 
    elsif
      ship.column(0) == ship.column(last) #is vertical
      p_comply = true 
    else
      puts "ships can only be laid horizontally or vertically. Please assign new coordinates"
      p_comply = false
    end
  end

  def overlaps?(ship, board) # ERROR!
    build_mid_squares(ship)    
    last = ship.cell.count - 1
    overlap = []   
    
    overlap = (0..last).map do |idx|
      p ship.column(idx)
      board.grid[ship.row(idx)][NUMBERS.index(ship.column(idx))] == " " #da error la columna y no entiendo porq - it returns nil
    end

    if overlap.include?(false)
      puts "Ships cannot overlap. Please assign new coordinates"
      overlap = false
    end
  end

  def squares_are_first_and_last(ship)
    f_l_comply = true
    last = ship.cell.count - 1
    if ship.row(0) == ship.row(last) #is horizontal
      if (ship.column(last) - ship.column(0) + 1).abs != ship.magnitude
        puts "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”) Please assign new coordinates"
        f_l_comply = false
      end
    elsif
      ship.column(0) == ship.column(last) #is vertical
      if (ship.row(last) - ship.row(0) + 1).abs != ship.magnitude
        puts "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”) Please assign new coordinates"
        f_l_comply = false
      end
    end
  end

  def computer_placement(computer_ships, comp_board) #pendiente de validar q no haya overlap
    @comp_board_size = @comp_board.board_size
    #inicio de loop q no se como hacer
    comp_ship_coord = computer_ships.map do |ship|
      random_comp_coordinates(ship, ship.magnitude, @comp_board_size)
    end
    computer_ships.map do |ship|
      ship_placement(ship, @comp_board)
    end
    p @comp_board.print_grid #eliminar
  end

  def random_comp_coordinates(ship, magnitude, board_size)
    position = rand(2)
    if position == 0 #horizontal
      row = rand(board_size)
      column = rand(board_size - magnitude + 1)
      ship << Cell.new("#{ALPHA[row]}#{column}")
      ship << Cell.new("#{ALPHA[row]}#{column + magnitude - 1}")
    else #vertical
      row = rand(board_size - magnitude + 1)
      column = rand(board_size)
      ship << Cell.new("#{ALPHA[row]}#{column}")
      ship << Cell.new("#{ALPHA[row + magnitude - 1]}#{column}")
    end
  end

  def player_shot_sequence(board_size)
    @user_shot_board = Grid.new(board_size)
    @user_shot_board.print_grid
    shot_prompt
    until validate_shot(shot, @comp_board) != false
      shot_prompt
    end
    execute_shot(@user_shot_board, @comp_board, shot)
  end

  def validate_shot(shot, board)
    shots = []
    shots << shot

    c_val = []
    c_val << false if shot_coor_comply?(shot, board) == false
    c_val << false if shots.include?(shot)
    c_val = false if c_val.include?(false)
  end

  def shot_coor_comply?(shot, board) #is outside of board
    size = board.board_size
    rows = rows_key(size - 1)
    columns = columns_key(size)

    s_comply = (0..index).map do |idx|
      rows.include?(shot.row) && columns.include?(shot.column)
    end
    if s_comply == false
      puts "The shot cannot be outside the board. Please assign new coordinates"
      s_comply
    end 
  end

  def execute_user_shot(user_shot_board, comp_board, shot)
    if @comp_board.grid[shot.row][shot.column] != " "
      @user_shot_board.grid[shot.row][shot.column] = "H"
      puts "You hit an enemy ship!"
    else 
      @user_shot_board.grid[shot.row][shot.column] = "M"
      puts "You missed!"
    end
  end

end