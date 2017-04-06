require './test/test_helper'
require './lib/4_grid.rb'

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
    assert_equal " ", board.grid[1][1]
    
    board.grid[1][1] = "x"
    assert_equal "x", board.grid[1][1]
  end
end