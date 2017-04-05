
module ShipPlacement

  ALPHA = ("A".."Z").to_a

  def columns_key
    ALPHA[0..board_size]
  end

  def rows_key
    numbers = (1..20).to_a
    numbers[0..board_size - 1]
  end

  def coordinates_comply?
    c_comply = true
    # c_comply = false if starting.any? { |word| word == "-" || word == "."}
    c_comply = false if columns_key.include?(y_start) == false || columns_key.include?(y_start) == false
  end

  def placement_complies?(grid, row, column)
    p_comply = false
    row_range = @grid[columns_key.index(y_end)] - @grid[columns_key.index(y_start)]
    column_range = @grid[x_end] - @grid[x_start]
    p_comply = true if (row_range == magnitude - 1 && column_range == 0) || (row_range == 0 && column_range == magnitude - 1)
  end

  def overlaps?(grid, row, column)
    symbols = ["<", ">", "^", "v", "*"]
    overlap = true
    overlap = false if !symbols.include?(grid[row][column])
  end
end