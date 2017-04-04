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

  def ship_placement_prompt
    puts "I have laid out my ships on the grid."
    puts "You now need to layout your two ships."
    puts "The first is two units long and the second is three units long."
    puts "The grid has A1 at the top left and D4 at the bottom right."
    puts
    puts "Enter the squares for the two-unit ship:"
  end
  
end
