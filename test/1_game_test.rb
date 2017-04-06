require './test/test_helper'
require './lib/ships.rb'
require './lib/grid.rb'
require './lib/cell.rb'
require './lib/battleship.rb'

class BattleshipTest < Minitest::Test

  # def setup
  #   @board = Grid.new(12)
  #   @ship = Ships.new("patrol")
  # end
  
  # def test_if_creates_ship
  #   assert_instance_of Ships, @ship
  # end

  def test_coordinates_comply?
    game = Battleship.new
    board_size = 4
    game.ship = Ships.new("submarine")
    game.ship << Cell.new("C3")
    game.ship << Cell.new("E3")
    game.ship.insert(1, Cell.new("D3"))

    refute game.coordinates_comply?(ship, board_size)
  end
end