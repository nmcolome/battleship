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
end