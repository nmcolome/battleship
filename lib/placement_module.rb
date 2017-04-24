module Placement

  def run_placement(board_size, number_of_ships)
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

end