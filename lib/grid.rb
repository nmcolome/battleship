require './lib/ship_placement.rb'

class Grid
  include ShipPlacement

  attr_reader :grid
  attr_accessor :board_size

  def initialize(board_size, value = " ")
    @board_size = board_size
    @grid = Array.new(board_size) { Array.new(board_size, value)}
  end

  def total_rows
    @grid.length
  end

  def total_columns
    @grid.first.length
  end

  def print_grid
    puts border.join
    print "*  "
    print rows_key.join("  ")
    puts
    @grid.each_with_index do |row, idx|
      print columns_key[idx]
      print "  "
      print row.join("  ")
      puts
    end
    print border.join
  end

  def border
    symbol = "==="
    borders = Array.new(board_size + 1, symbol)
  end

  # def update_grid(grid)
  #   grid.print_grid
  # end

end