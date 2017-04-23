class Computer
  attr_reader :comp_arrangement,
              :comp_shots,
              :comp_ships

  def initialize(board_size, number_of_ships)
    @comp_arrangement = Board.new(board_size)
    @comp_shots = Board.new(board_size)
    @comp_ships = []
    computer_placement(board_size, number_of_ships)
  end

  def computer_placement(board_size, number_of_ships)
    ships = create_ships(number_of_ships)
    ships.each do |ship|
      ship_placement(ship, board_size)
    end
    @comp_ships = ships
  end

  def create_ships(number)
    ships = ["Destroyer", "Submarine", "Battleship", "Carrier"]
    ships = ships[0..number - 1]
    ships.map { |ship| Ship.new(ship) }
  end

  def ship_placement(ship, board_size)
    border_limit = board_size - ship.size + 1
    column = rand(border_limit)
    row = rand(border_limit)
    ship_head = [row, column]
    ship << ship_head
    assign_coordinates(ship)
  end

  def is_horizontal?
    false
    true if rand(2) == 0
  end

  def assign_coordinates(ship)
    row = ship.location.first.first
    column = ship.location.first.last

    if is_horizontal?
      (ship.size).times do |i|
        ship.location << [row, column + i]
      end
    else
      (ship.size).times do |i|
        ship.location << [row + i, column]
      end
    end

    ship.location.shift
  end

end