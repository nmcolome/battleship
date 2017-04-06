require './lib/6_cell.rb'

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

  def count
    @cell.count
  end

  def clear
    @cell = []
  end

  def insert(position, cell)
    @cell.insert(position, cell)
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

  def last_row
    @cell.last.row
  end
  
  def last_column
    @cell.last.column
  end
  
end