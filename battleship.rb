require './lib/game'

class Battleship
  def initialize
    @game = Game.new.start
  end
end

game = Battleship.new