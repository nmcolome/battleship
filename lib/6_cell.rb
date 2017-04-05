require './lib/ship_placement.rb'

class Cell
include ShipPlacement

  attr_reader :row, :column, :coordinates
  
  def initialize(coordinates)
    @coordinates = coordinates.split(//)
    @row = ABC.index(coordinates[0])
    @column = coordinates[1].to_i - 1
  end
  
end