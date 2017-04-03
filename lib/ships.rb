require './lib/grid.rb'

class Ships
  attr_reader :head, :tail, :type

  def initialize(type, head, tail)
    @head = head
    @tail = tail
    @type = type
  end
  
  def magnitude #why do I have to put return in order for the test to work
    return 2 if type == "patrol"
    return 3 if type == "submarine"
    return 3 if type == "destroyer"
    return 4 if type == "battleship"
    return 5 if type == "carrier"
  end
    
end