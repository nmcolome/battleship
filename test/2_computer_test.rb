require './test/test_helper'
require './lib/2_computer.rb'

class ComputerTest < Minitest::Test
  
  def setup
    @comp = Computer.new(4, 2)
  end

  def test_if_creates_AI
    assert_instance_of Computer, @comp
  end

  def test_if_creates_ship_layout
    @comp.comp_ship_coordenates(2, 4)
  end
end