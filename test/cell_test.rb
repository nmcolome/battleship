require './test/test_helper'
require './lib/ships.rb'
require './lib/grid.rb'
require './lib/cell.rb'

class CellTest < Minitest::Test
  
  def test_if_creates_cell
    c = Cell.new("A1")
    assert_instance_of Cell, c
  end

  def test_it_outputs_the_row
    c = Cell.new("A1")
    assert_equal "A", c.row
  end

  def test_it_outputs_the_column
    c = Cell.new("A1")
    assert_equal "1", c.column
  end
end