require './test/test_helper'
require './lib/battleship'
require './lib/computer'


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

    @user.all_coord << @destroyer.location
    @user.all_coord << @submarine.location

    @user.shots << [0,0]
    @user.shots << [3,1]
    @user.shots << [2,3]
    @user.shots << [0,2]
    @game.computer = @computer
    @game.user = @user
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

    refute @game.check_dead(user_status)
    refute @game.check_dead(comp_status)
  end

  # def test_computer_hit
  #   @computer.shots << [0,0]
  #   assert @game.enemy_got_hit?(@computer, @user)

  #   @computer.shots << [3,0]
  #   refute @game.enemy_got_hit?(@computer, @user)
  # end

  def test_when_computer_makes_a_hit
    @computer.shots << [0,0]
    assert_nil @game.check_enemy_board(@computer, @user)

    expected = [["H", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]
    assert_equal expected, @user.user_arrangement.grid
  end

  def test_when_player_makes_a_hit
    @computer.all_coord = [[[0, 1], [1, 1]], [[1, 2], [2, 2], [3, 2]]]

    @user.shots << [1,2]
    assert_nil @game.check_enemy_board(@user, @computer)

    expected = [[" ", " ", " ", " "], [" ", " ", "H", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]
    assert_equal expected, @user.user_shots.grid
  end

  def test_when_computer_misses
    @computer.shots << [3,3]
    assert_nil @game.check_enemy_board(@computer, @user)

    expected = [[" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", "M"]]
    assert_equal expected, @user.user_arrangement.grid
  end

  def test_when_player_misses
    @computer.all_coord = [[[0, 1], [1, 1]], [[1, 2], [2, 2], [3, 2]]]

    @user.shots << [3,3]
    assert_nil @game.check_enemy_board(@user, @computer)

    expected = [[" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", "M"]]
    assert_equal expected, @user.user_shots.grid
  end

  def test_when_computer_sinks_a_ship
    @computer.shots << [0,0]
    assert_nil @game.check_enemy_board(@computer, @user)
    @computer.shots << [1,0]
    assert_nil @game.check_enemy_board(@computer, @user)

    expected = [["H", " ", " ", " "], ["H", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]
    assert_equal expected, @user.user_arrangement.grid
  end

  def test_when_player_sinks_a_ship
    @computer.ships.first.location = [[0, 1], [1, 1]]
    @computer.ships.last.location = [[1, 2], [2, 2], [3, 2]]
    @computer.all_coord = [[[0, 1], [1, 1]], [[1, 2], [2, 2], [3, 2]]]

    @user.shots << [1,1]
    assert_nil @game.check_enemy_board(@user, @computer)
    @user.shots << [0,1]
    assert_nil @game.check_enemy_board(@user, @computer)

    expected = [[" ", "H", " ", " "], [" ", "H", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]
    assert_equal expected, @user.user_shots.grid
  end

  def test_when_player_wins
    skip
    @computer.ships.first.location = [[0, 1], [1, 1]]
    @computer.ships.last.location = [[1, 2], [2, 2], [3, 2]]
    @computer.all_coord = [[[0, 1], [1, 1]], [[1, 2], [2, 2], [3, 2]]]

    @user.shots << [1,1]
    assert_nil @game.check_enemy_board(@user, @computer)
    @user.shots << [0,1]
    assert_nil @game.check_enemy_board(@user, @computer)
    @user.shots << [1,2]
    assert_nil @game.check_enemy_board(@user, @computer)
    @user.shots << [2,2]
    assert_nil @game.check_enemy_board(@user, @computer)
    @user.shots << [3,2]
    assert_nil @game.check_enemy_board(@user, @computer)

    assert_equal "cat", @user.user_shots.grid
  end

  def test_when_computer_wins
    skip
    @computer.shots << [0,0]
    assert_nil @game.check_enemy_board(@computer, @user)
    @computer.shots << [1,0]
    assert_nil @game.check_enemy_board(@computer, @user)

    expected = [["H", " ", " ", " "], ["H", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]
    assert_equal expected, @user.user_arrangement.grid
  end
  # def test_board_update_if_the_computer_misses
  #   @computer.shots << [3,0]
  #   output = @game.player_misses(@computer)
  #   expected = [[" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], ["M", " ", " ", " "]]

  #   assert_nil output #there is an error message
  #   assert_equal expected, @user.user_arrangement.grid
  # end

  # def test_board_update_if_its_a_hit
  #   @computer.shots << [0,0]
  #   output = @game.update_board(@computer)
  #   expected = [["H", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "]]

  #   assert_equal "H", output
  #   assert_equal expected, @user.user_arrangement.grid
  # end

  # def test_hit_message_for_a_computer_hit
  #   @computer.shots << [0,0]
  #   assert_nil @game.hit_message(@user)
  # end

  # def test_hit_message_for_a_player_hit
  #   assert_nil @game.hit_message(@computer)
  # end

  # def test_board_update_if_the_player_misses
  #   @user.shots << [3,3]
  #   output = @game.player_misses(@user)
  #   expected = [[" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", " "], [" ", " ", " ", "M"]]

  #   assert_nil output #there is an error message
  #   assert_equal expected, @user.user_shots.grid
  # end

  # def test_message_when_it_sinks_a_ship
  #   @game.hit_or_sink_message(@destroyer, @computer, @user)
  # end
end