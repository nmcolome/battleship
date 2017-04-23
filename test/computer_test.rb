require './test/test_helper'
require './lib/computer'
require './lib/board'
require './lib/ship'

class TestComputer < Minitest::Test

  def setup
    @comp = Computer.new(4,2)
  end

  def test_it_exists
    assert_instance_of Computer, @comp
  end

  def test_computer_placement
    assert_equal 2, @comp.comp_ships.count
    assert_instance_of Array, @comp.comp_ships
    refute @comp.comp_ships.first.location.empty?
  end

  def test_creation_of_ships
    assert_equal 3, @comp.create_ships(3).count
    assert_instance_of Ship, @comp.create_ships(3).first
    assert_equal "Destroyer", @comp.create_ships(3).first.name
  end

  def test_assignment_of_coordinates
    submarine = Ship.new("Submarine")
    submarine << [0, 0]
    @comp.assign_coordinates(submarine)

    assert_equal 3, submarine.location.count
    horizontal = [[0, 0], [0, 1], [0, 2]] == submarine.location
    vertical = [[0, 0], [1, 0], [2, 0]] == submarine.location
    assert horizontal || vertical
  end

end