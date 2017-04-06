require './test/test_helper'
require './lib/3_user.rb'

class UserTest < Minitest::Test
  
  def setup
    @user = User.new(4, 2)
  end

  def test_if_creates_user
    assert_instance_of User, @user

    assert_equal 2, @user.num_of_ships
    assert_equal 4, @user.board_size
  end

  def test_if_creates_ship_layout
    skip
    @user.game_setup(2, 4)
  end
  
  def test_shot_sequence
    board = Grid.new(4)
    shot = Cell.new("A1")
    @user.player_shot_sequence(shot, board)
  end
  
end