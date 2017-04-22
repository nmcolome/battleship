require './test/test_helper'
require './lib/battleship'

class TestBattleship < Minitest::Test

  def test_it_exists
    game = Battleship.new

    assert_instance_of Battleship, game
  end

  def test_when_user_quits
    game = Battleship.new
    expected = "Hope to see you again!"

    assert_equal expected, game.selection("q")
    assert_equal expected, game.selection("quit")
  end
end