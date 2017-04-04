module Messages

  def welcome
    puts "Welcome to BATTLESHIP"
    puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
  end

  def instructions
    handle = File.open("./lib/instructions.txt", "r")
    puts handle.read
    handle.close
  end

  def quit
    puts "You exited the game succesfully"
  end

  def level
    puts "What difficulty level would you like to play?"
    puts "(b)eginner = 4x4 grid, 2-unit boat, 3-unit boat"
    puts "inter(m)ediate = 8x8 grid, 2-unit boat, 3-unit boat, 4-unit boat"
    puts "(a)dvanced = 12x12 grid, 2-unit boat, 3-unit boat, 4-unit boat, 5-unit boat"
  end
  
end
