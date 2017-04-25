require './test/test_helper'
require './lib/board'

class TestBoard < Minitest::Test

  def test_it_exists
    board_game = Board.new(4)
    assert_instance_of Board, board_game
  end

  def test_it_creates_a_square_array_of_arrays
    board_game = Board.new(8)
    assert_equal 8, board_game.grid.length
    assert_equal 8, board_game.grid.first.length
  end

  def test_it_prints_borders
    board_game = Board.new(4)
    assert_instance_of Array, board_game.border

    expected = "============"
    assert_equal expected, board_game.border.join
  end

  def test_it_prints_x_axis
    skip
    board_game = Board.new(4)
    assert_nil board_game.print_x_axis
  end

  def test_it_prints_y_axis
    skip
    board_game = Board.new(4)
    assert_instance_of Array, board_game.print_y_axis
  end

  def test_it_prints_grid_with_headers
    board_game = Board.new(4)

    output = board_game.print_grid
    assert_nil output
  end
end