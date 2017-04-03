module ShipPlacement
  
  def columns_key
    alpha = ("A".."Z").to_a
    alpha[0..size]
  end

  def rows_key
    numbers = (1..20).to_a
    numbers[0..size - 1]
  end

  def ship_placement_coordinates(head, tail)
    starting = head.split(//)
    ending = tail.split(//)
    y_start = columns_key.index(starting[0])
    x_start = rows_key.index(starting[1])
    y_end = columns_key.index(ending[0])
    x_end = rows_key.index(ending[1])
  end

  def random_comp_coordinates(ship_type, magnitude)
    position = rand(2)
    if position = 0 #horizontal
      row = rand(size)
      column = rand(size - magnitude)
      comp_ship_type = Ships.new(ship_type, "#{row}#{column}", "#{row}#{column + size - 1}")
    else
      row = rand(size-magnitude)
      column = rand(size)
      comp_ship_type = Ships.new(ship_type, "#{row}#{column}", "#{row + size - 1}#{column}")
    end
  end
  
  def ship_setup(y_start, x_start, y_end, x_end)
    if y_start == y_end
      @grid[y_start][x_start] = "<"
      @grid[y_end][x_end] = ">"
      until index == x_end
        index = x_start.next
        @grid[y_start][index] = "*"
      end
    else
      @grid[y_start][x_start] = "^"
      @grid[y_end][x_end] = "v"
      until grid_row == x_end
        grid_row = y_start.next
        @grid[grid_row][x_start] = "*"
      end
    end
  end

  def coordinates_comply?
    c_comply = true
    c_comply = false if starting.any? { |word| word == "-" || word == "."}
    c_comply = false if columns_key.include?(y_start) == false || columns_key.include?(y_start) == false
  end

  def placement_complies?
    p_comply = false
    row_range = @grid[columns_key.index(y_end)] - @grid[columns_key.index(y_start)]
    column_range = @grid[x_end] - @grid[x_start]
    p_comply = true if (row_range == magnitude - 1 && column_range == 0) || (row_range == 0 && column_range == magnitude - 1)
  end

  def overlaps?(row,column)
    overlap = true
    overlap = false if grid[row][column] == "^"
  end

end