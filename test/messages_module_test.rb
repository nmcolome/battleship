require './test/test_helper'
require './lib/messages_module'
require './lib/ship'
require './lib/computer'
require './lib/user'
require './lib/board'

class TestMessages < Minitest::Test
include Messages

  def setup
    @destroyer = Ship.new("Destroyer")
    @submarine = Ship.new("Submarine")
    @computer = Computer.new(4,2)
    @user = User.new(4,2)
  end

  def test_welcome_output
    assert_nil welcome
  end

  def test_read_instructions
    assert_nil read_instructions
  end

  def test_quits_output
    assert_nil quits
  end

  def test_request_action
    assert_nil request_action
  end

  def test_difficulty_level
    assert_nil difficulty_level
  end

  def test_prompt_user_setup
    assert_nil prompt_user_setup("b")
    assert_nil prompt_user_setup("i")
    assert_nil prompt_user_setup("a")
  end

  def test_prompt_coordinates
    assert_nil prompt_coordinates(2)
  end

  def test_position_error
    assert_nil position_error
  end

  def test_overlap_error
    assert_nil overlap_error
  end

  def test_wrap_error
    assert_nil wrap_error
  end

  def test_length_error
    assert_nil length_error
  end

  def test_prompt_player_shot
    assert_nil prompt_player_shot
  end

  def test_your_shot_board
    assert_nil your_shot_board
  end

  def test_your_arrangement_board
    assert_nil your_arrangement_board
  end

  def test_shot_board_error
    assert_nil shot_board_error
  end

  def test_repeated_shot_error
    assert_nil repeated_shot_error
  end

  def test_user_hit_message
    assert_nil user_hit_message
  end

  def test_miss_message
    assert_nil miss_message
  end

  def test_comp_hit_message
    assert_nil comp_hit_message([0,0])
  end

  def test_comp_miss_message
    assert_nil comp_miss_message([0,0])
  end

  def test_sink_user
    assert_nil sink_user(@destroyer)
  end

  def test_sink_comp
    assert_nil sink_comp(@submarine)
  end

  def test_sorry
    assert_nil sorry("1:00 minutes")
  end

  def test_congrats
    assert_nil congrats("1:00 minutes")
  end

  def test_end_turn
    assert_nil end_turn
  end
end