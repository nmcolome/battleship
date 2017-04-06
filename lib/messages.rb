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
    puts "(a)dvanced = 12x12 grid, 2-unit boat, 3-unit boat, 3-unit boat, 4-unit boat, 5-unit boat"
  end

  def message_setup(board_size, ships)
    puts "I have laid out my ships on the grid."
    puts "You now need to layout your #{ships} ships."
    if ships == 5
      puts "The first is the patrol (2-units long), then the submarine (3-units), then the destroyer (3-units), then the battleship (4-units) and finally the carrier (5-units long)"
      puts "The grid is #{board_size}x#{board_size}, it has A1 at the top left and L12 at the bottom right."
    elsif 
      ships == 4
      puts "The first is the patrol (2-units long), then the submarine (3-units), then the destroyer (3-units), and finally the battleship (4-units long)"
      puts "The grid is #{board_size}x#{board_size}, it has A1 at the top left and H8 at the bottom right."
    elsif 
      ships == 2
      puts "The first is the patrol (2-units long) and the second is the submarine (3-units long)"
      puts "The grid is #{board_size}x#{board_size}, it has A1 at the top left and D4 at the bottom right."
    end
    puts
  end
  
end
