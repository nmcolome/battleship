# require './lib/4_grid.rb'
# require './lib/5_ships.rb'
# require './lib/6_cell.rb'

module Keys

  ABC = ("A".."Z").to_a

  def rows_key(board_size)
    ABC[0..board_size]
  end

  NUMS = (1..20).to_a

  def columns_key(board_size)
    NUMS[0..board_size - 1]
  end
end
