require './test/test_helper'
require './lib/6_cell.rb'

class CellTest < Minitest::Test
  
  def setup
    @c = Cell.new("A1")    
  end

  def test_if_creates_cell
    assert_instance_of Cell, @c
  end

  def test_it_outputs_the_row
    assert_equal 0, @c.row
  end

  def test_it_outputs_the_column
    assert_equal 0, @c.column
  end

  def test_it_outputs_the_coordinates
    assert_equal ["A", "1"], @c.coordinates
  end

end