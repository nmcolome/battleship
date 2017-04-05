require './test/test_helper'
require './lib/ships.rb'
require './lib/grid.rb'
require './lib/cell.rb'

class ShipsTest < Minitest::Test

  def setup
    @board = Grid.new(12)
    @ship = Ships.new("patrol")
  end
  
  def test_if_creates_ship
    assert_instance_of Ships, @ship
  end
end