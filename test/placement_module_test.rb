require './test/test_helper'
require './lib/ship'
require './lib/computer'
require './lib/user'
require './lib/board'

class TestPlacement < Minitest::Test
include Placement

  def setup
    @computer = Computer.new(4,2)
  end

  def test_creation_of_ships
    assert_equal 3, create_ships(3).count
    assert_instance_of Array, create_ships(2)
    assert_instance_of Ship, create_ships(2).first
  end

  def test_run_placement_for_computer
    assert_equal 2, @computer.run_placement(4,2).count
  end

end