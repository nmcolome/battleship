require './test/test_helper'
require './lib/user'
require './lib/board'
require './lib/ship'

class TestUser < Minitest::Test

  def setup
    @player = User.new(4, 2)
    @destroyer = Ship.new("Destroyer")
    @submarine = Ship.new("Submarine")
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
    assert @player.is_length_ok?(["A","1"], ["A","2"], @destroyer)
    assert @player.is_length_ok?(["A","1"], ["C","1"], @submarine)
    refute @player.is_length_ok?(["A","1"], ["A","4"], @destroyer)
    refute @player.is_length_ok?(["A","1"], ["A","2"], @submarine)
  end

  def test_wrapping_validation_of_coordinates
    assert @player.no_wrapping?(["A","1"], ["A","4"])
    refute @player.no_wrapping?(["D","1"], ["E","1"])
    refute @player.no_wrapping?(["G","1"], ["G","4"])
  end

  def test_overlap_validation_of_coordinates
    assert @player.no_overlap?(["A", "1"], ["A", "2"], @destroyer)
    refute @player.no_overlap?(["A", "1"], ["A", "3"], @submarine)
  end

  def test_all_validations
    assert @player.validate_ship_coord(["B", "2"], ["B", "3"], @destroyer)
    refute @player.validate_ship_coord(["A", "2"], ["C", "2"], @submarine)
    assert @player.validate_ship_coord(["A", "1"], ["C", "1"], @submarine)
  end

  def test_format_validate_coordinates
    destroyer = Ship.new("Destroyer")
    submarine = Ship.new("Submarine")
    @player.format_validate_coordinates(destroyer, "a1 a2")

    assert_equal [[0, 0], [0, 1]], @player.user_ships.first.location

    @player.format_validate_coordinates(submarine, "B1 D1")
    assert_equal [[1, 0], [2, 0], [3, 0]], @player.user_ships.last.location
  end

end
