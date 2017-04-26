require './lib/placement_module'

class Computer
  include Placement
  attr_reader :comp_arrangement,
              :comp_shots,
              :ships,
              :shots
  attr_accessor :all_coord

  def initialize(board_size, number_of_ships)
    @comp_arrangement = Board.new(board_size)
    @comp_shots = Board.new(board_size)
    @ships = []
    @all_coord = []
    @shots = []
    run_placement(board_size, number_of_ships)
  end

  def ship_placement(ship, board_size)
    ship_head = assign_ship_head(ship, board_size)
    ship << ship_head
    assign_full_coordinates(ship)
    validate_coord(ship, board_size)
  end

  def assign_ship_head(ship, board_size)
    border_limit = board_size - ship.size + 1

    if is_horizontal?
      column = rand(border_limit)
      row = rand(board_size - 1)
    else
      column = rand(board_size - 1)
      row = rand(border_limit)
    end

    ship_head = [row, column]
  end

  def is_horizontal?
    false
    true if rand(2) == 0
  end

  def assign_full_coordinates(ship)
    row = ship.location.first.first
    column = ship.location.first.last

    if is_horizontal?
      (ship.size - 1).times do |i|
        ship.location << [row, column + i + 1]
      end
    else
      (ship.size - 1).times do |i|
        ship.location << [row + i + 1, column]
      end
    end
  end

  def validate_coord(ship, board_size)
    @all_coord << ship.location
    if all_coord.flatten(1).uniq!.nil?
      @ships << ship
    else
      @all_coord.delete_at(-1)
      ship.reset
      ship_placement(ship, board_size)
    end
  end

  def shoot
    limit = comp_shots.size
    shot = [rand(limit).to_i, rand(limit).to_i]
    validate_shot(shot)
  end

  def validate_shot(shot)
    if @shots.include?(shot)
      shoot
    else
      @shots << shot
    end
  end

end