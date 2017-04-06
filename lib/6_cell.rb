require './lib/ship_setup.rb'

class Cell
  include ShipSetup

  attr_reader :row, :column, :coordinates
  
  def initialize(coordinates)
    @coordinates = coordinates.split(//)
    @row = ABC.index(coordinates[0])
    @column = coordinates[1].to_i - 1
  end
  
end