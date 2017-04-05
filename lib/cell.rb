class Cell
  attr_reader :row, :column, :coordinates
  
  def initialize(coordinates)
    @coordinates = coordinates.split(//)
    @row = coordinates[0]
    @column = coordinates[1]
  end
end