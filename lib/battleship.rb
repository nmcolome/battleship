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
      @computer = Computer.new(4, 2)
      prompt_user_setup("b")
      @user = User.new(4, 2)
      user.run_placement(4, 2)
    elsif input == "i" || input == "intermediate"
      @computer = Computer.new(8, 3)
      prompt_user_setup("i")
      @user = User.new(8, 3)
      user.run_placement(8, 3)
    elsif input == "a" || input == "advanced"
      @computer = Computer.new(12, 4)
      prompt_user_setup("a")
      @user = User.new(12, 4)
      user.run_placement(12, 4)
    end
    game_flow(computer, user)
  end

  def game_flow
    your_arrangement_board
    user.user_arrangement.print_grid
    your_shot_board
    user.user_shots.print_grid
    user.shoot
    check_enemy_board(user, computer)
    computer.shoot
    check_enemy_board(computer, user)
  end

  def game_over
    @is_over = false
    while is_over == false
      game_flow
      check_if_over
    end
  end

  def check_if_over
    user_status = get_status(user)
    comp_status = get_status(computer)
    @is_over = true if check_dead(user_status) || check_dead(comp_status)
  end

  def check_dead(player)
    player_status.all? {|stat| stat == "sunk"}
  end

  def enemy_status(enemy)
    status = get_status(enemy)
    if enemy == computer
      congrats if status.all? {|stat| stat == "sunk"}
    else
      sorry if status.all? {|stat| stat == "sunk"}
    end
  end

  def get_status(enemy)
    enemy.ships.map { |ship| ship.status }
  end


  def check_enemy_board(player, enemy)
    if enemy_got_hit?(player, enemy)
      update_board(player)
      check_if_hit_or_sink(player, enemy)
      enemy_status(enemy)
    else
      player_misses(player)
      prompt_if_user(player)
    end
  end

  def prompt_if_user(player)
    if player == @user
      user.user_shots.print_grid
      end_turn
      enter = gets.chomp
    end
  end

  def enemy_got_hit?(player, enemy)
    enemy.all_coord.flatten(1).include?(player.shots.last)
  end

  def update_board(player)
    if player == computer
      user.update_arrangement_board("H", player.shots.last)
    else
      user.update_shot_board("H", player.shots.last)
    end
  end

  def enemy_status(enemy)
    status = get_status(enemy)
    if enemy == computer
      congrats if status.all? {|stat| stat == "sunk"}
    else
      sorry if status.all? {|stat| stat == "sunk"}
    end
  end

  def get_status(enemy)
    enemy.ships.map { |ship| ship.status }
  end

  def check_if_hit_or_sink(player, enemy)
    enemy.ships.each do |ship|
      if ship.location.include?(player.shots.last)
        hit_or_sink_message(player, enemy)
      end
    end
  end

  def hit_or_sink_message(player, enemy)
    if (ship.location & player.shots).count == ship.size
      ship.status = "sunk"
      sink_message(enemy)
    else
      hit_message(enemy)
    end
  end

  def sink_message(enemy)
    if enemy == computer
      sink_comp(ship)
    else
      sink_user(ship)
    end
  end

  def hit_message(enemy)
    if enemy == computer
      user_hit_message
    else
      comp_hit_message
    end
  end

  def player_misses(player)
    if player == computer
      user.update_arrangement_board("M", computer.shots.last)
      comp_miss_message
    else
      user.update_shot_board("M", user.shots.last)
      miss_message
    end
  end

end