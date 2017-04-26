require './lib/messages_module'
require './lib/computer'
require './lib/user'
require './lib/board'
require './lib/ship'

class Game
  include Messages

  attr_reader :start_time

  attr_accessor :computer,
                :user

  def initialize
    @computer = ""
    @user = ""
    @is_over = false
  end

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
    @start_time = Time.now
    setup_based_on_difficulty(input)
    your_arrangement_board
    @user.show_arrangement
    your_shot_board
    run_game
  end

  def setup_based_on_difficulty(input)
    if input == "b" || input == "beginner"
      initialize_both_players("b", 4, 2)
    elsif input == "i" || input == "intermediate"
      initialize_both_players("i", 8, 3)
    elsif input == "a" || input == "advanced"
      initialize_both_players("a", 12, 4)
    end
  end

  def initialize_both_players(input, board_size, amount_of_ships)
    @computer = Computer.new(board_size, amount_of_ships)
    prompt_user_setup(input)
    @user = User.new(board_size, amount_of_ships)
    user.run_placement(board_size, amount_of_ships)
  end

  def user_flow
    @user.user_shots.print_grid
    @user.shoot
    check_enemy_board(@user, @computer)
    request_enter
  end

  def comp_flow
    computer.shoot
    check_enemy_board(computer, user)
    @user.user_arrangement.print_grid
    request_enter
  end

  def request_enter
    end_turn
    enter = gets
  end

  def run_game
    while @is_over == false
      user_flow
      break if enemy_status(@computer)
      comp_flow
      break if enemy_status(@user)
    end
  end

  def check_dead(player_status)
    player_status.all? {|stat| stat == "sunk"}
  end

  def get_status(enemy)
    enemy.ships.map { |ship| ship.status }
  end

  def elapsed_time
    end_time = Time.now
    time = end_time - start_time
    format_time(time)
  end

  def format_time(time)
    m = time / 60
    s = time % 60
    "#{m.to_i}:#{s.to_i} minutes"
  end

  def enemy_status(enemy)
    enemy_status = get_status(enemy)
    if enemy == computer
      if check_dead(enemy_status)
        congrats(user, elapsed_time)
        @is_over = true
      end
    else
      if check_dead(enemy_status)
        sorry(@computer, elapsed_time)
        @is_over = true
      end
    end
  end

  def check_enemy_board(player, enemy)
    if enemy_got_hit?(player, enemy)
      update_board(player)
      check_if_hit_or_sink(player, enemy)
      prompt_if_user(player)
    else
      player_misses(player)
      prompt_if_user(player)
    end
  end

  def prompt_if_user(player)
    if player == @user
      @user.user_shots.print_grid
    end
  end

  def enemy_got_hit?(player, enemy)
    enemy.all_coord.flatten(1).include?(player.shots.last)
  end

  def update_board(player)
    if player == @computer
      @user.update_arrangement_board("H", player.shots.last)
    else
      @user.update_shot_board("H", player.shots.last)
    end
  end

  def check_if_hit_or_sink(player, enemy)
    enemy.ships.each do |ship|
      if ship.location.include?(player.shots.last)
        hit_or_sink_message(ship, player, enemy)
      end
    end
  end

  def hit_or_sink_message(ship, player, enemy)
    if (ship.location & player.shots).count == ship.size
      ship.status = "sunk"
      sink_message(ship, enemy)
    else
      hit_message(enemy)
    end
  end

  def sink_message(ship, enemy)
    if enemy == @computer
      sink_comp(ship)
    else
      sink_user(ship)
    end
  end

  def hit_message(enemy)
    if enemy == @computer
      user_hit_message
    else
      comp_hit_message(@computer.shots.last)
    end
  end

  def player_misses(player)
    if player == @computer
      @user.update_arrangement_board("M", @computer.shots.last)
      comp_miss_message(@computer.shots.last)
    else
      @user.update_shot_board("M", @user.shots.last)
      miss_message
    end
  end

end