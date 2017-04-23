require './lib/messages_module'

class User
  include Messages

  def initialize(board_size, number_of_ships)
    @user_arrangement = Board.new(board_size)
    @user_shots = Board.new(board_size)
    @user_ships = []
    user_placement(board_size, number_of_ships)
  end

  def user_placement(board_size, number_of_ships)
    ships = create_ships(number_of_ships)
    ships.each do |ship|
      ship_placement(ship, board_size)
    end
    @comp_ships = ships
    validate_coord(board_size, number_of_ships)
  end

  def create_ships(number)
    ships = ["Destroyer", "Submarine", "Battleship", "Carrier"]
    ships = ships[0..number - 1]
    ships.map { |ship| Ship.new(ship) }
  end

  def ship_placement(ship, board_size)
    prompt_coordinates(board_size)
    coordinates = gets.chomp
    coordinates.split(" ")
    ship_head = coordinates[0].split(//)
    ship_tail = coordinates[1].split(//)
    validate_coord(ship_head, ship_tail)
  end

  def validate_coord(head, tail)
    position_error if is_position_ok?(head, tail) == false
    length_error if is_length_ok?(head, tail) == false
    wrap_error if is_wrapping?(head, tail) == false
  end

    # overlap_error if overlaps?(head,tail) == false

  # def overlaps?(head, tail)
    # if horizontal?(head, tail)
      # size = tail[1] - head[1] + 1
  # end

  def is_wrapping?(head, tail)
    columns = (1..size).to_a
    rows = ("A".."Z").to_a[size-1]

    rows_inside_board(head, tail) && columns_inside_board(head, tail)
  end

  def rows_inside_board
    rows.include?(head[0]) && rows.include?(tail[0])
  end

  def columns_inside_board
    columns.include?(head[1]) && columns.include?(tail[1])
  end

  def is_position_ok?(head, tail)
    false
    true if horizontal?(head, tail) || vertical?(head, tail)
  end

  def is_length_ok?(head, tail)
    rows = ("A".."Z").to_a[size-1]
    false
    true if horizontal_length(head, tail) || vertical_length(head, tail)
  end

  def horizontal?(head, tail)
    head[0] == tail[0]
  end

  def horizontal_length_ok?(head, tail)
    tail[1] - head[1] == ship.size - 1
  end

  def vertical?(head, tail)
    head[1] == tail[1]
  end

  def vertical_length_ok?(head, tail)
    rows.index(tail[0]) - rows.index(head[0]) == ship.size - 1
  end

  def horizontal_length(head, tail)
    horizontal?(head, tail) && horizontal_length_ok?(head, tail)
  end

  def vertical_length(head, tail)
    vertical?(head, tail) && vertical_length_ok?(head, tail)
  end
end