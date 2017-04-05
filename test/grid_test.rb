require './test/test_helper'
require './lib/grid.rb'

class GridTest < Minitest::Test
  
  def test_if_creates_board
    board = Grid.new(10)

    assert_instance_of Grid, board
  end

  def test_if_creates_boards_of_different_sizes
    board = Grid.new(12)
    assert_equal 12, board.total_rows
    assert_equal 12, board.total_columns

    board = Grid.new(8)
    assert_equal 8, board.total_rows
    assert_equal 8, board.total_columns

    board = Grid.new(4)
    assert_equal 4, board.total_rows
    assert_equal 4, board.total_columns
  end
  
  def test_if_edit_a_specific_cell
    board = Grid.new(10)
    rowss = board.grid[1]
    rowss[1] = "x"
    p board.grid
    assert_equal "x", board.grid[1][1]
  end

#   def test_if_print_the_board_correctly #how to do this
#     skip
#     board = Grid.new(8)

#     desired_output = W
# ===========================
# *  A  B  C  D  E  F  G  H
# 1  ^  ^  ^  ^  ^  ^  ^  ^
# 2  ^  ^  ^  ^  ^  ^  ^  ^
# 3  ^  ^  ^  ^  ^  ^  ^  ^
# 4  ^  ^  ^  ^  ^  ^  ^  ^
# 5  ^  ^  ^  ^  ^  ^  ^  ^
# 6  ^  ^  ^  ^  ^  ^  ^  ^
# 7  ^  ^  ^  ^  ^  ^  ^  ^
# 8  ^  ^  ^  ^  ^  ^  ^  ^
# ===========================
#     assert_equal desired_output, board.print_grid
#   end
end