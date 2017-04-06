
module ShipSetup

  ABC = ("A".."Z").to_a

  def rows_key(board_size)
    ABC[0..board_size]
  end

  NUMS = (1..20).to_a

  def columns_key(board_size)
    NUMS[0..board_size - 1]
  end

  def ship_creation(num_of_ships)
    ships_types = ["patrol", "submarine", "destroyer", "battleship", "carrier"]    
    ships_types[0..num_of_ships - 1].map {|type| Ships.new(type)}    
  end
  
  def build_mid_squares(ship)
    if ship.row(0) == ship.row(1) #is horizontal
      middle = ship.column(0).next
      until middle == ship.last_column
        position = 1
        ship.insert(position, Cell.new("#{ABC[ship.row(0)]}#{middle + 1}"))
        position += 1
        middle += 1
      end
    else
      middle = ship.row(0).next
      until middle == ship.last_row
        position = 1
        ship.insert(position, Cell.new("#{ABC[middle]}#{ship.column(0) + 1}"))
        position +=1
        middle += 1
      end
    end
  end
  
  def ship_placement(ships, board) # previous ship setup
    ships.each do |ship|
      if ship.row(0) == ship.row(1) #is horizontal
        (0..ship.magnitude - 1).each do |index|
          board.grid[ship.row(0)][ship.column(index)] = ">"
        end
      else
        (0..ship.magnitude - 1).each do |index|
          board.grid[ship.row(index)][ship.column(0)] = "v"
        end
      end
    end
    # board.print_grid
  end

  # def execute_shot(user_shot_board, shot)
  #   if @comp_board.grid[shot.row][shot.column] != " "
  #     user_shot_board.grid[shot.row][shot.column] = "H"
  #     puts "You hit an enemy ship!"
  #   else 
  #     @user_shot_board.grid[shot.row][shot.column] = "M"
  #     puts "You missed!"
  #   end
  # end

end