require './lib/cell.rb'
require './lib/ship_placement.rb'

class Ships
  include ShipPlacement

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

  def clear
    @cell = []
  end

  def insert(position, cell)
    @cell.insert(position, cell)
  end

  def row(cell_idx)
    letter = @cell[cell_idx].row
    ALPHA.index(letter)
  end

  def column(cell_idx)
    @cell[cell_idx].column.to_i
  end

  def coordinates(cell_idx)
    @cell[cell_idx].coordinates
  end
end