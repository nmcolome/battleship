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
  
end
