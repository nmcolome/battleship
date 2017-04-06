require './lib/ship_setup.rb'

class Grid
  include ShipSetup

  attr_reader :grid
  attr_accessor :size

  def initialize(size, value = " ")
    @size = size
    @grid = Array.new(size) { Array.new(size, value)}
  end

  def total_rows
    grid.length
  end

  def total_columns
    grid.first.length
  end

  def print_grid
    puts border.join
    print "*  "
    print columns_key(@size).join("  ")
    puts
    grid.each_with_index do |row, idx|
      print rows_key(@size)[idx]
      print "  "
      print row.join("  ")
      puts
    end
    puts border.join
  end

  def border
    borders = Array.new(size + 1, "===")
  end
  
end