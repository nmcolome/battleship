require './test/test_helper'
require './lib/ships.rb'
require './lib/grid.rb'

class ShipsTest < Minitest::Test

  def setup
    @board = Grid.new(12)
    @ship = Ships.new("patrol","B1","B2")
  end
  
  def test_if_creates_ship
    assert_instance_of Ships, @ship
  end

  def test_it_has_a_type
    assert_equal "patrol", @ship.type
  end

  def test_if_outputs_correct_size
    # skip
    assert_equal 2, @ship.magnitude

    ship_1 = Ships.new("submarine","B1","B3")
    assert_equal 3, ship_1.magnitude

    ship_2 = Ships.new("battleship","B1","B4")
    assert_equal 4, ship_2.magnitude
    
    ship_3 = Ships.new("carrier","B1","B5")
    assert_equal 5, ship_3.magnitude    
  end
end