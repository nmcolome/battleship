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

  def test_creation_of_ships
    assert_equal 3, @comp.create_ships(3).count
    assert_instance_of Ship, @comp.create_ships(3).first
    assert_equal "Destroyer", @comp.create_ships(3).first.name
  end

  def test_assignment_of_coordinates
    submarine = Ship.new("Submarine")
    submarine.location << [0, 0]
    @comp.assign_full_coordinates(submarine, true)

    assert_equal 3, submarine.location.count
    horizontal = [[0, 0], [0, 1], [0, 2]] == submarine.location
    assert horizontal
  end

  def test_validation_of_coordinates
    assert_equal [], @comp.ships.first.location & @comp.ships.last.location
  end

  def test_computer_placement
    assert_equal 2, @comp.ships.count
    assert_instance_of Array, @comp.ships
    refute @comp.ships.first.location.empty?
  end

  def test_comp_shoot_is_within_board
    @comp.shoot
    shot = @comp.shots.first
    output = @comp.comp_shots.grid.at(shot[0]).at(shot[1])

    assert_equal " ", output
  end

  def test_shots_are_all_different
    @comp.shoot
    @comp.shoot
    @comp.shoot
    @comp.shoot
    @comp.shoot
    @comp.shoot

    assert_nil @comp.shots.uniq!
  end
end