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
end