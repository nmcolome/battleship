# require './lib/ship_setup'

module CoordinatesValidation
  # include ShipSetup
  
  def coord_validation(ship, board)
    # binding.pry
    c_val = []
    c_val << false if coordinates_comply?(ship, board) == false
    c_val << false if placement_complies?(ship) == false
    c_val << false if squares_are_first_and_last(ship) == false
    c_val = false if c_val.include?(false)
  end

  def coordinates_comply?(ship, board) #is outside of board
    size = board.size
    index = ship.cell.count - 1
    rows = (0..size - 1).to_a
    columns = (0..size - 1).to_a
    c_comply = []
    c_comply = (0..index).map do |idx|
      rows.include?(ship.row(idx)) && columns.include?(ship.column(idx))
    end
    
    if c_comply.include?(false)
      puts "Ships cannot wrap around the board. Please assign new coordinates"
      c_comply = false      
    end 
  end

  def placement_complies?(ship)
    if ship.row(0) == ship.last_row #is horizontal
      p_comply = true 
    elsif
      ship.column(0) == ship.last_column #is vertical
      p_comply = true 
    else
      puts "ships can only be laid horizontally or vertically. Please assign new coordinates"
      p_comply = false
    end
  end

  def no_overlap?(ships)
    overlap = false
    coord = []
    coordinates = ships.map do |ship|
      length = ship.magnitude - 1
      (0..length).each do |idx|
        coord << ship.coordinates(idx)
      end
    end
    overlap = true if coord.uniq!.nil?
    overlap
  end

  def overlap_message
    puts "Ships cannot overlap. Please assign new coordinates"
  end
  
  def squares_are_first_and_last(ship)
    f_l_comply = true
    if ship.row(0) == ship.last_row #is horizontal
      if (ship.last_column - ship.column(0) + 1).abs != ship.magnitude
        puts "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”) Please assign new coordinates"
        f_l_comply = false
      end
    elsif
      ship.column(0) == ship.last_column #is vertical
      if (ship.last_row - ship.row(0) + 1).abs != ship.magnitude
        puts "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”) Please assign new coordinates"
        f_l_comply = false
      end
    end
  end

  def validate_shot(shot, board)
    val_s = []
    val_s << false if right_coordinates?(shot, board) == false
    val_s << false if repeated_shot(shot) == false    
    val_s = false if val_s.include?(false)    
  end

  def right_coordinates?(shot, board) #is outside of board
    size = board.size
    rows = (0..size - 1).to_a
    columns = (0..size - 1).to_a
    right_c = rows.include?(shot.row) && columns.include?(shot.column)
    puts "Your shot was outside the board. Please select a new coordinate" if right_c == false
    right_c
  end

  def repeated_shot(shot)
    r_shot = true
    shots = []
    if shots.include?(shot)
      puts "You've already fired in this position before. Please select a new coordinate"
      r_shot = false
    else
      shots << shot
    end
    r_shot
  end

end