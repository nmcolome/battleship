require './lib/messages.rb'
require './lib/ship_setup.rb'
require './lib/5_ships.rb'
require './lib/4_grid.rb'
require './lib/6_cell.rb'
require './lib/2_computer.rb'
require './lib/3_user.rb'

require 'pry'

class Battleship
  include Messages
  include ShipSetup

  def welcome_message
    puts welcome
    action = gets.chomp
      case action
    when "p" || "play"
      level_selection
    when "i" || "instructions"
      instructions
      puts
      puts
      welcome_message
    when "q" || "quit"
      quit
    end
  end

  def level_selection
    level
    selection = gets.chomp
      case selection
    when "a" || "advanced"
      run(12, 5)
    when "m" || "intermediate"
      run(8, 4)
    when "b" || "beginner"
      run(4, 2)
    end
  end
  
  def run(board_size, num_of_ships)
    @ai = Computer.new(board_size, num_of_ships)
    message_setup(board_size, num_of_ships)
    @player = User.new(board_size, num_of_ships)
    war(board_size, num_of_ships)
    
    # finish_him(board_size, num_of_ships)
  end

  def finish_him(board_size, num_of_ships)
    comp_status = @ai.comp_board.grid.flatten!
    player_status = @player.board.grid.flatten!
    until comp_status.count("H") == 5 || player_status.count("H") == 5
      war(board_size, num_of_ships)
    end
    if comp_status.count("H") == 5
      "You win!"
    else
      "You lose!"
    end
  end
  
  def war(board_size, num_of_ships)
    shot = @player.game_setup(board_size, num_of_ships)
    execute_shot(shot)     
    ai_shot = @ai.shot_sequence(board_size)
    p ai_shot
    execute_ai_shot(ai_shot)
  end

  def execute_shot(shot)
    if @ai.comp_board.grid[shot.row][shot.column] != " "
      @player.user_shot_board.grid[shot.row][shot.column] = "H"
      @player.user_shot_board.print_grid
      puts "You hit an enemy ship!"
    else 
      @player.user_shot_board.grid[shot.row][shot.column] = "M"
      @player.user_shot_board.print_grid
      puts "You missed!"
    end
  end

  def execute_ai_shot(ai_shot)
    if @player.board.grid[ai_shot.row][ai_shot.column] != " "
      @player.board.grid[ai_shot.row][ai_shot.column] = "H"
      @player.board.print_grid
      puts "You've been hit!"
    else
      @player.board.grid[ai_shot.row][ai_shot.column] = "M"
      @player.board.print_grid      
      puts "The computer missed!"
    end
  end
end