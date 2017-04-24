module Messages

  def welcome
    puts "Welcome to BATTLESHIP\n"
  end

  def read_instructions
    puts File.read("./lib/instructions.txt")
  end

  def quits
    print "Hope to see you again!"
  end

  def request_action
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def difficulty_level
    puts "Which difficulty level would you like to play:\n* (b)eginner = 4x4 grid, 2-unit boat, 3-unit boat\n* (i)ntermediate = 8x8 grid, 2-unit boat, 3-unit boat, 4-unit boat\n (a)dvanced = 12x12 grid, 2-unit boat, 3-unit boat, 4-unit boat, 5-unit boat"
  end

  def prompt_user_setup(level)
    if level == "b"
      puts "I have laid out my ships on the grid. \nYou now need to layout your two ships.\nThe first is two units long and the second is three units long.\nThe grid is 4x4, has A1 at the top left and D4 at the bottom right.\n"
    elsif level == "i"
      puts "I have laid out my ships on the grid. \nYou now need to layout your three ships.\nThe first is two units long, the second is three units long and the third is four units long.\nThe grid is 8x8, has A1 at the top left and H8 at the bottom right.\n"
    elsif
      puts "I have laid out my ships on the grid. \nYou now need to layout your three ships.\nThe first is two units long, the second is three units long, the third is four units long and the fourth is five units long.\nThe grid is 12x12, has A1 at the top left and L12 at the bottom right.\n"
    end
  end

  def prompt_coordinates(size)
    puts "Enter the squares for the #{size}-unit ship:"
  end

  def position_error
    return "Ships can only be laid either horizontally or vertically"
  end

  def overlap_error
    return "Ships cannot overlap"
  end

  def wrap_error
    return "Ships cannot wrap around the board"
  end

  def length_error
    return "Coordinates must correspond to the first and last units of the ship. (IE: You can’t place a two unit ship at “A1 A3”)"
  end

  def prompt_player_shot
    puts "Please enter the square where you want to shoot (EG “A1”):"
  end

  def your_shot_board
    puts "This is your shot board."
  end

  def your_arrangement_board
    puts "This is your arrangement board."
  end

  def hit_message
    puts "Your shot hit an enemy ship!"
  end

  def miss_message
    puts "Your shot was a Miss"
  end

  def comp_hit_message
    puts "You got hit!"
  end

  def comp_miss_message
    puts "The enemy missed!"
  end

  def sink_user(ship)
    puts "The enemy sunk your #{ship.size}-unit #{ship}"
  end

  def sink_comp(ship)
    puts "You sunk the enemy's #{ship.size}-unit #{ship}"
  end

  def sorry
    puts "Sorry! You lose!"
  end

  def congrats
    puts "Congratulations! You win!"
  end
end