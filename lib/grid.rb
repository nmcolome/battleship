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
    print "-  "
    print columns_key(@board_size).join("  ")
    puts
    @grid.each_with_index do |row, idx|
      print rows_key(@board_size)[idx]
      print "  "
      print row.join("  ")
      puts
    end
    puts border.join
  end

  def border
    borders = Array.new(board_size + 1, "===")
  end

  # def update_grid(grid)
  #   grid.print_grid
  # end

end