require './lib/game'
require 'pry'

class Battleship
  def initialize
    @game = Game.new.start
  end
end

Battleship.new