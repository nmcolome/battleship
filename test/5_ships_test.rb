require './test/test_helper'
require './lib/5_ships.rb'
require './lib/6_cell.rb'

class ShipsTest < Minitest::Test

  def setup
    @ship = Ships.new("patrol")
  end
  
  def test_if_creates_ship
    assert_instance_of Ships, @ship
  end

  def test_it_has_a_type
    assert_equal "patrol", @ship.type
  end

  def test_if_outputs_correct_size
    assert_equal 2, @ship.magnitude

    ship_1 = Ships.new("submarine")
    assert_equal 3, ship_1.magnitude

    ship_2 = Ships.new("battleship")
    assert_equal 4, ship_2.magnitude
    
    ship_3 = Ships.new("carrier")
    assert_equal 5, ship_3.magnitude
  end

  def test_if_adds_cells
    assert_equal [], @ship.cell

    @ship << Cell.new("A2")
    @ship << Cell.new("A3")
    assert_equal 2, @ship.count
  end

  def test_it_inserts_new_cells
    assert_equal [], @ship.cell

    @ship << Cell.new("A2")
    @ship << Cell.new("A4")
    @ship.insert(1, Cell.new("A3"))
    
    assert_equal 3, @ship.cell.count
    assert_equal ["A", "2"], @ship.coordinates(0)
    assert_equal ["A", "3"], @ship.coordinates(1)
    assert_equal ["A", "4"], @ship.coordinates(2)
  end

  def test_it_outputs_the_row
    @ship << Cell.new("A2")
    @ship << Cell.new("A3")
    
    assert_equal 0, @ship.row(0)
    assert_equal 0, @ship.row(1)
  end

  def test_it_outputs_the_column
    @ship << Cell.new("A2")
    @ship << Cell.new("A3")

    assert_equal 1, @ship.column(0)
    assert_equal 2, @ship.column(1)
  end

  def test_it_outputs_the_coordinates
    @ship << Cell.new("A2")
    @ship << Cell.new("A3")

    assert_equal ["A", "2"], @ship.coordinates(0)
    assert_equal ["A", "3"], @ship.coordinates(1)
  end

  def test_it_can_delete_data_of_cell
    @ship << Cell.new("A2")
    @ship << Cell.new("A3")

    assert_equal ["A", "2"], @ship.coordinates(0)
    assert_equal ["A", "3"], @ship.coordinates(1)

    @ship.clear
    assert_equal 0, @ship.cell.count
  end

  def test_it_can_access_last_data_of_cell
    @ship << Cell.new("A2")
    @ship << Cell.new("A3")
    @ship << Cell.new("A4")
    @ship << Cell.new("B5")

    assert_equal ["A", "2"], @ship.coordinates(0)
    assert_equal ["A", "3"], @ship.coordinates(1)

    assert_equal 4, @ship.last_column
    assert_equal 1, @ship.last_row
  end

#move to another test
  def test_it_creates_middle_cells_if_ship_is_horizontal
    skip
    l_ship = Ships.new("carrier")
    l_ship << Cell.new("D2")
    l_ship << Cell.new("D6")
    
    assert_equal 2, l_ship.count
    assert_equal 5, l_ship.magnitude

    build_mid_squares(l_ship)
    p ship
    assert_equal 5, l_ship.count
  end

  def test_it_creates_middle_cells_if_ship_is_vertical
    skip
    l_ship = Ships.new("carrier")
    l_ship << Cell.new("A1")
    l_ship << Cell.new("E1")
    
    assert_equal 2, l_ship.count
    assert_equal 5, l_ship.magnitude

    build_mid_squares(l_ship)
    p ship
    assert_equal 5, l_ship.count
  end
end