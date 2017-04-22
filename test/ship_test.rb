require './test/test_helper'
require './lib/ship.rb'

class TestShip < Minitest::Test

  def test_it_exists
    sub = Ship.new("Submarine", 3)

    assert_instance_of Ship, sub
  end

  def test_addition_of_location_to_ship
    sub = Ship.new("Submarine", 3)
    ship_head = [0,0]
    ship_tail = [0,1]

    sub << ship_head
    sub << ship_tail

    assert_equal 2, sub.location.count
    assert_equal [0,0], sub.location.first
  end

end