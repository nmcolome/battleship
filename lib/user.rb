require './lib/messages_module'
require './lib/placement_module'

class User
  include Placement
  include Messages

  attr_reader :user_arrangement,
              :user_shots,
              :ships,
              :all_coord,
              :shots

  ABC = ("A".."Z").to_a

  def initialize(board_size, number_of_ships)
    @user_arrangement = Board.new(board_size)
    @user_shots = Board.new(board_size)
    @ships = []
    @all_coord = []
    @shots = []
  end

  def ship_placement(ship, board_size)
    prompt_coordinates(ship.size)
    coordinates = gets.chomp
    if coordinates == ""
      ship_placement(ship, board_size)
    else
      format_validate_coordinates(ship, coordinates)
    end
  end

  def format_validate_coordinates(ship, coordinates)
    coord = coordinates.split(" ")
    ship_head = [coord[0][0], coord[0][1..2]]
    ship_tail = [coord[1][0], coord[1][1..2]]
    assign_mid_coordinates(ship, ship_head, ship_tail)
    if validate_ship_coord(ship_head, ship_tail, ship)
      @ships << ship
    else
      ship.reset
      all_coord.pop
      ship_placement(ship, user_arrangement.size)
    end
  end

  def assign_mid_coordinates(ship, head, tail)
    row = ABC.index(head[0].upcase)
    column = head[1].to_i - 1
    ship_head = [row, column]
    ship.location << ship_head
    create_mid_coord(ship, head, tail, row, column)
  end

  def create_mid_coord(ship, head, tail, row, column)
    if horizontal?(head, tail)
      (ship.size - 1).times do |i|
        ship.location << [row, column + i + 1]
      end
    else
      (ship.size - 1).times do |i|
        ship.location << [row + i + 1, column]
      end
    end
  end

  def validate_ship_coord(head, tail, ship)
    good_coord = true
    coord_val = []
    coord_val << false if is_position_ok?(head, tail) == false
    coord_val << false if is_length_ok?(head, tail, ship) == false
    coord_val << false if no_wrapping?(head, tail) == false
    coord_val << false if no_overlap?(ship) == false
    good_coord = false if coord_val.any? {|validation| validation == false}
    good_coord
  end

  def is_position_ok?(head, tail)
    position = false
    if horizontal?(head, tail) || vertical?(head, tail)
      position = true
    else
      position_error
    end
    position
  end

  def horizontal?(head, tail)
    head[0] == tail[0]
  end

  def vertical?(head, tail)
    head[1] == tail[1]
  end

  def is_length_ok?(head, tail, ship)
    length = false
    if horizontal_length(head, tail, ship) || vertical_length(head, tail, ship)
      length = true
    else
      length_error
    end
    length
  end

  def horizontal_length(head, tail, ship)
    tail[1].to_i - head[1].to_i == ship.size - 1
  end

  def vertical_length(head, tail, ship)
    ABC.index(tail[0].upcase) - ABC.index(head[0].upcase) == ship.size - 1
  end

  def no_wrapping?(head, tail)
    wrapping = false
    if rows_inside_board(head, tail) && columns_inside_board(head, tail)
      wrapping = true
    else
      wrap_error
    end
    wrapping
  end

  def rows_inside_board(head, tail)
    rows = ABC[0..user_arrangement.size-1]
    rows.include?(head[0].upcase) && rows.include?(tail[0].upcase)
  end

  def columns_inside_board(head, tail)
    columns = (1..user_arrangement.size).to_a
    columns.include?(head[1].to_i) && columns.include?(tail[1].to_i)
  end

  def no_overlap?(ship)
    all_coord << ship.location
    overlap = false
    if all_coord.flatten(1).uniq!.nil?
      overlap = true
    else
      overlap_error
    end
    overlap
  end

  def show_arrangement
    @ships.each do |ship|
      if ship.location.first[0] == ship.location.last[0]
        ship.location.each do |coord|
          user_arrangement.grid[coord.first][coord.last] = ">"
        end
      else
        ship.location.each do |coord|
          user_arrangement.grid[coord.first][coord.last] = "v"
        end
      end
    end
    user_arrangement.print_grid
  end

  def prompt_for_shot
    prompt_player_shot
    input = gets.chomp
  end

  def shoot
    input = prompt_for_shot
    while input == ""
      input = prompt_for_shot
    end
    shot = [ABC.index(input[0].upcase), input[1..2].to_i - 1]
    validate_shot(shot)
  end

  def validate_shot(shot)
    if inside_board?(shot) && is_new?(shot)
      @shots << shot
    else
      error_messages(shot)
      shoot
    end
  end

  def error_messages(shot)
    if inside_board?(shot) == false
      shot_board_error
    else
      repeated_shot_error
    end
  end

  def inside_board?(shot)
    size = (0...user_shots.size).to_a
    size.include?(shot[0]) && size.include?(shot[1])
  end

  def is_new?(shot)
    !@shots.include?(shot)
  end

  def update_shot_board(letter, shot)
    user_shots.grid[shot.first][shot.last] = letter
  end

  def update_arrangement_board(letter, shot)
    user_arrangement.grid[shot.first][shot.last] = letter
  end
end