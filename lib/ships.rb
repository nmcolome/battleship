require './lib/grid.rb'
require './lib/cell.rb'

class Ships
  attr_reader :type, :head, :tail

  def initialize(type)
    @type = type    
    @head = head
    @tail = tail
  end
  
  def magnitude
    case type
      when "patrol"
        2
      when "submarine"
        3
      when "destroyer"
        3
      when "battleship"
        4
      when "carrier"
        5
    end
  end
end