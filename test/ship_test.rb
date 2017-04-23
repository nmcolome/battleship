require './test/test_helper'
require './lib/ship.rb'

class TestShip < Minitest::Test

  def setup
    @sub = Ship.new("Submarine")
  end

  def test_it_exists
    assert_instance_of Ship, @sub
  end

  def test_addition_of_location_to_ship
    ship_head = [0,0]
    ship_tail = [0,1]

    @sub << ship_head
    @sub << ship_tail

    assert_equal 2, @sub.location.count
    assert_equal [0,0], @sub.location.first
  end

  def test_access_to_ship_data
    assert_equal "Submarine", @sub.name
    assert_equal 3, @sub.size
    assert_equal [], @sub.location
  end

end