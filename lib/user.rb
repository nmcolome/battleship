require './lib/messages_module'
require './lib/placement_module'

class User
  include Messages
  include Placement

  attr_reader :user_arrangement,
              :user_shots,
              :user_ships,
              :all_coord

  ABC = ("A".."Z").to_a

  def initialize(board_size, number_of_ships)
    @user_arrangement = Board.new(board_size)
    @user_shots = Board.new(board_size)
    @user_ships = []
    @all_coord = []
    # run_placement(board_size, number_of_ships)
  end

  # def run_placement(board_size, number_of_ships)
  #   ships = create_ships(number_of_ships)
  #   ships.each do |ship|
  #     ship_placement(ship)
  #   end
  # end

  # def create_ships(number)
  #   ships = ["Destroyer", "Submarine", "Battleship", "Carrier"]
  #   ships = ships[0..number - 1]
  #   ships.map { |ship| Ship.new(ship) }
  # end

  def ship_placement(ship)
    prompt_coordinates(ship.size)
    coordinates = gets.chomp
    format_validate_coordinates(ship, coordinates)
  end

  def format_validate_coordinates(ship, coordinates)
    coord = coordinates.split(" ")
    ship_head = coord[0].split(//)
    ship_tail = coord[1].split(//)
    if validate_ship_coord(ship_head, ship_tail, ship.size)
      ship << [ABC.index(ship_head[0]), ship_head[1].to_i - 1]
      ship << [ABC.index(ship_tail[0]), ship_tail[1].to_i - 1]
      @user_ships << ship
    else
      ship_placement(ship)
    end
  end

  def validate_ship_coord(head, tail, ship_size)
    good_coord = true
    coord_val = []
    coord_val << false if is_position_ok?(head, tail) == false
    coord_val << false if is_length_ok?(head, tail, ship_size) == false
    coord_val << false if no_wrapping?(head, tail) == false
    coord_val << false if no_overlap?(head, tail, ship_size) == false
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

  def is_length_ok?(head, tail, ship_size)
    length = false
    if horizontal_length(head, tail, ship_size) || vertical_length(head, tail, ship_size)
      length = true
    else
      length_error
    end
    length
  end

  def horizontal_length(head, tail, ship_size)
    tail[1].to_i - head[1].to_i == ship_size - 1
  end

  def vertical_length(head, tail, ship_size)
    ABC.index(tail[0]) - ABC.index(head[0]) == ship_size - 1
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
    rows.include?(head[0]) && rows.include?(tail[0])
  end

  def columns_inside_board(head, tail)
    columns = (1..user_arrangement.size).to_a
    columns.include?(head[1].to_i) && columns.include?(tail[1].to_i)
  end

  def no_overlap?(head, tail, ship_size)
    row = ABC.index(head[0])
    column = head[1].to_i - 1
    ship_head = [row, column]
    all_coord << ship_head

    if horizontal?(head, tail)
      (ship_size - 1).times do |i|
        all_coord << [row, column + i + 1]
      end
    else
      (ship_size - 1).times do |i|
        all_coord << [row + i + 1, column]
      end
    end

    overlap = false
    if all_coord.uniq!.nil?
      overlap = true
    else
      overlap_error
    end
    overlap
  end

end