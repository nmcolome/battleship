require './lib/messages_module'

class Battleship
  include Messages

  def start
    welcome
    request_input
  end

  def selection(input)
    if input == "p" || input == "play"
      select_difficulty_level
    elsif input == "i" || input == "instructions"
      read_instructions
      request_input
    elsif input == "q" || input == "quit"
      quits
    end
  end

  def request_input
    request_action
    input = gets.chomp
    selection(input)
  end

  def select_difficulty_level
    difficulty_level
    input = gets.chomp
    game_setup(input)
  end

  def game_setup(input)
    if input == "b" || input == "beginner"
      computer = Computer.new(4, 2)
      prompt_user_setup("b")
      user = User.new(4, 2)
      user.run_placement(4, 2)
    elsif input == "i" || input == "intermediate"
      computer = Computer.new(8, 3)
      prompt_user_setup("i")
      user = User.new(8, 3)
      user.run_placement(8, 3)
    elsif input == "a" || input == "advanced"
      computer = Computer.new(12, 4)
      prompt_user_setup("a")
      user = User.new(12, 4)
      user.run_placement(12, 4)
    end
    game_flow(computer, user)
  end

  def game_flow(computer, user)
    
  end

end