
module ShipPlacement

  ALPHA = ("A".."Z").to_a

  def rows_key(board_size)
    ALPHA[0..board_size]
  end

  NUMBERS = (1..20).to_a

  def columns_key(board_size)
    NUMBERS[0..board_size - 1]
  end
end