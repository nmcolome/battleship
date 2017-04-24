class Computer
  attr_reader :comp_arrangement,
              :comp_shots,
              :comp_ships,
              :all_coord

  def initialize(board_size, number_of_ships)
    @comp_arrangement = Board.new(board_size)
    @comp_shots = Board.new(board_size)
    @comp_ships = []
    @all_coord = []
    computer_placement(board_size, number_of_ships)
  end

  def computer_placement(board_size, number_of_ships)
    ships = create_ships(number_of_ships)
    ships.each do |ship|
      ship_placement(ship, board_size)
    end
  end

  def create_ships(number)
    ships = ["Destroyer", "Submarine", "Battleship", "Carrier"]
    ships = ships[0..number - 1]
    ships.map { |ship| Ship.new(ship) }
  end

  def ship_placement(ship, board_size)
    ship_head = assign_ship_head(ship, board_size)
    ship << ship_head
    assign_full_coordinates(ship)
    validate_coord(ship, board_size)
    # binding.pry
  end

  def assign_ship_head(ship, board_size)
    border_limit = board_size - ship.size + 1

    if is_horizontal?
      column = rand(border_limit)
      row = rand(board_size - 1)
    else
      column = rand(board_size - 1)
      row = rand(border_limit)
    end

    ship_head = [row, column]
  end

  def is_horizontal?
    false
    true if rand(2) == 0
  end

  def assign_full_coordinates(ship)
    row = ship.location.first.first
    column = ship.location.first.last

    if is_horizontal?
      (ship.size - 1).times do |i|
        ship.location << [row, column + i + 1]
      end
    else
      (ship.size - 1).times do |i|
        ship.location << [row + i + 1, column]
      end
    end
  end

  def validate_coord(ship, board_size)
    @all_coord << ship.location
    if all_coord.flatten(1).uniq!.nil?
      @comp_ships << ship
    else
      @all_coord.delete_at(-1)
      ship.reset
      ship_placement(ship, board_size)
    end
  end

end