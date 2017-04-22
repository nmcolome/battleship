require './test/test_helper'
require './lib/messages_module'

class TestMessages < Minitest::Test

include Messages

  def test_welcome_output
    expected = "Welcome to BATTLESHIP

    Would you like to (p)lay, read the (i)nstructions, or (q)uit"

    assert_equal expected, welcome
  end
end