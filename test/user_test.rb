require './test/test_helper'
require './lib/user'
require './lib/board'
require './lib/ship'

class TestUser < Minitest::Test

  def setup
    @player = User.new(4,2)
  end

  def test_it_exists
    assert_instance_of User, @player
  end

  def test_creation_of_ships
    @player.create_ships(2)

    assert_equal 2, @player.user_ships.count
    assert_equal Array, @player.user_ships
    assert_equal Ship, @player.user_ships.first.class
  end
end