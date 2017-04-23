require './test/test_helper'
require './lib/user'
require './lib/board'
require './lib/ship'

class TestUser < Minitest::Test

  def setup
    @player = User.new(4, 2)
  end

  def test_it_exists
    assert_instance_of User, @player
  end

  def test_creation_of_ships
    assert_equal 3, @player.create_ships(3).count
    assert_instance_of Array, @player.create_ships(2)
    assert_instance_of Ship, @player.create_ships(2).first
  end
end