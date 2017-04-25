require './test/test_helper'
require './lib/battleship'

class TestBattleship < Minitest::Test

  def setup
    @game = Battleship.new
    @computer = Computer.new(4, 2)
    @user = User.new(4, 2)
    @destroyer = Ship.new("Destroyer")
    @destroyer.location << [0,0]
    @destroyer.location << [1,0]
    @submarine = Ship.new("Submarine")
    @submarine.location << [2,1]
    @submarine.location << [2,2]
    @submarine.location << [2,3]

    @user.ships << @destroyer
    @user.ships << @submarine


  end

  def test_it_exists
    assert_instance_of Battleship, @game
  end

  # def test_when_user_quits
  #   skip
  #   game = Battleship.new

  #   assert_nil game.selection("q")
  #   assert_nil game.selection("quit")
  # end

  # def test_instructions
  #   skip
  #   game = Battleship.new

  #   assert_nil game.selection("i")
  #   assert_nil game.selection("instructions")
  # end

  # def test_playing_at_beginners_level
  #   game = Battleship.new

  #   assert_nil game.start
  # end

  def test_all_ships_are_alive_at_the_beginning
    user_status = @game.get_status(@user)
    comp_status = @game.get_status(@computer)

    assert_equal ["alive", "alive"], user_status
    assert_equal ["alive", "alive"], comp_status
    assert_equal "cat", @game.computer

    refute @game.check_dead(user_status)
    refute @game.check_dead(comp_status)
  end

  def method_name
    
  end
end