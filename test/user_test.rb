require './test/test_helper'
require './lib/user'
require './lib/board'
require './lib/ship'

class TestUser < Minitest::Test

  def setup
    @player = User.new(4, 2)
  end

  def test_it_exists
    assert_instance_of User, @player
  end

  def test_creation_of_ships
    assert_equal 3, @player.create_ships(3).count
    assert_instance_of Array, @player.create_ships(2)
    assert_instance_of Ship, @player.create_ships(2).first
  end

  def test_position_validation_of_coordinates
    assert @player.is_position_ok?(["A","1"], ["A","2"])
    assert @player.is_position_ok?(["A","1"], ["B","1"])
    refute @player.is_position_ok?(["A","1"], ["B","2"])
  end

  def test_length_validation_of_coordinates
    assert @player.is_length_ok?(["A","1"], ["A","2"], 2)
    assert @player.is_length_ok?(["A","1"], ["C","1"], 3)
    refute @player.is_length_ok?(["A","1"], ["A","4"], 2)
    refute @player.is_length_ok?(["A","1"], ["A","2"], 3)
  end

  def test_wrapping_validation_of_coordinates
    assert @player.no_wrapping?(["A","1"], ["A","4"])
    refute @player.no_wrapping?(["D","1"], ["E","1"])
    refute @player.no_wrapping?(["G","1"], ["G","4"])
  end

  def test_overlap_validation_of_coordinates
    assert @player.no_overlap?(["A", "1"], ["A", "2"], [], 2)
    refute @player.no_overlap?(["A", "1"], ["A", "3"], [[0, 0], [0, 1]], 3)
    refute @player.no_overlap?(["A", "2"], ["C", "2"], [[1, 1], [1, 2]], 3)
  end

  def test_all_validations
    assert @player.validate_ship_coord(["B", "2"], ["B", "3"], 2, [])
    refute @player.validate_ship_coord(["B", "2"], ["B", "3"], 3, [[1, 1], [1, 2]])
  end
end