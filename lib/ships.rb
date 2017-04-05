# require './lib/grid.rb'
require './lib/cell.rb'

class Ships
  attr_accessor :type, :cell

  def initialize(type)
    @type = type    
    @cell = []
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

  def << (cell)
    @cell << cell
  end

  def row(cell_idx)
    @cell[cell_idx].row
  end

  def column(cell_idx)
    @cell[cell_idx].column
  end

  def coordinates(cell_idx)
    @cell[cell_idx].coordinates
  end
end