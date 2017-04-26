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
    assert @player.position_ok?(["A","1"], ["A","2"])
    assert @player.position_ok?(["A","1"], ["B","1"])
    refute @player.position_ok?(["A","1"], ["B","2"])
  end

  def test_length_validation_of_coordinates
    assert @player.length_ok?(["A","1"], ["A","2"], @destroyer)
    assert @player.length_ok?(["A","1"], ["C","1"], @submarine)
    refute @player.length_ok?(["A","1"], ["A","4"], @destroyer)
    refute @player.length_ok?(["A","1"], ["A","2"], @submarine)
  end

  def test_wrapping_validation_of_coordinates
    assert @player.no_wrapping?(["A","1"], ["A","4"])
    refute @player.no_wrapping?(["D","1"], ["E","1"])
    refute @player.no_wrapping?(["G","1"], ["G","4"])
  end

  def test_overlap_validation_of_coordinates
    @destroyer << ["A", "1"]
    @destroyer << ["A", "2"]
    assert @player.no_overlap?(@destroyer)

    @destroyer << ["A", "1"]
    @destroyer << ["A", "2"]
    @destroyer << ["A", "3"]
    refute @player.no_overlap?(@submarine)
  end

  def test_all_validations
    @destroyer << ["B", "2"]
    @destroyer << ["B", "3"]
    assert @player.validate_ship_coord(["B", "2"], ["B", "3"], @destroyer)

    @submarine << ["A", "2"]
    @submarine << ["B", "2"]
    @submarine << ["C", "2"]
    refute @player.validate_ship_coord(["A", "2"], ["C", "2"], @submarine)
  end

  def test_format_validate_coordinates
    @player.format_validate_coordinates(@destroyer, "a1 a2")

    assert_equal [[0, 0], [0, 1]], @player.ships.first.location

    @player.format_validate_coordinates(@submarine, "B1 D1")
    assert_equal [[1, 0], [2, 0], [3, 0]], @player.ships.last.location
  end

  def test_show_arrangement
    @destroyer << [0,0]
    @destroyer << [0,1]

    @submarine << [0,3]
    @submarine << [1,3]
    @submarine << [2,3]

    @player.ships << @destroyer
    @player.ships << @submarine

    assert_nil @player.show_arrangement
  end

  def test_shot_validation
    input = "B3"
    shot = [1, 2]
    @player.validate_shot(shot)
    assert_equal [[1,2]], @player.shots
  end

  def test_run_placement_for_user
    @player.run_placement(4, 2)
    #enter a1 a2
    # assert_equal [[0,0], [0,1]], @player.ships.first.location
    assert_equal 2, @player.ships.first.location.count
    #enter a2 c2 - get error message
    #enter c1 c3
    # assert_equal [[2,0], [2,1], [2,2]], @player.ships.last.location
    assert_equal 3, @player.ships.last.location.count
    # assert_equal [[[0,0], [0,1]], [[2,0], [2,1], [2,2]]], @player.all_coord
    assert_equal 2, @player.all_coord.count
  end

  def test_error_messages
    input = "B3"
    shot = [1, 2]
    @player.validate_shot(shot)
    shot_2 = [1, 0]
    @player.validate_shot(shot_2) #its a repeated shot, enter  "b1"

    assert_equal 2, @player.shots.count

    @player.validate_shot([7, 7]) #its outside the board, enter "a1"
    assert_equal 3, @player.shots.count
  end

  def test_update_player_shot_board
    assert_equal "H", @player.update_shot_board("H", [0,1])
    assert_equal "M", @player.update_shot_board("M", [2,2])

    expected = [[" ", "H", " ", " "], [" ", " ", " ", " "], [" ", " ", "M", " "], [" ", " ", " ", " "]]
    assert_equal expected, @player.user_shots.grid
  end

  def test_update_player_arrangement_board_to_see_if_its_been_hit
    assert_equal "H", @player.update_arrangement_board("H", [1,2])
    assert_equal "M", @player.update_arrangement_board("M", [3,3])

    expected = [[" ", " ", " ", " "], [" ", " ", "H", " "], [" ", " ", " ", " "], [" ", " ", " ", "M"]]
    assert_equal expected, @player.user_arrangement.grid
  end

end