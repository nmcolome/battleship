class Board
  attr_reader :size,
              :value,
              :grid

  def initialize(size, value = " ")
    @size = size
    @value = value
    @grid = Array.new(size) { Array.new(size, value)}
  end

  def columns_key(size)
    (1..size).to_a
  end

  def rows_key(size)
    ("A".."Z").to_a
  end

  def print_grid
    puts border.join
    print_x_axis
    print_y_axis
    puts border.join
  end

  def border
    borders = Array.new(size + 1, "===")
  end

  def print_x_axis
    puts "*  " + columns_key(size).join("  ")
  end

  def print_y_axis
    grid.each_with_index do |row, idx|
      puts rows_key(size)[idx] + " " + row.join("  ")
    end
  end

end