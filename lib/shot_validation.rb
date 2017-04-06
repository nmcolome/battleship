module ShotValidation
  
    def validate_shot(shot, board)
    shots = []
    shots << shot

    c_val = []
    c_val << false if shot_coor_comply?(shot, board) == false
    c_val << false if shots.include?(shot)
    c_val = false if c_val.include?(false)
  end

  def shot_coor_comply?(shot, board) #is outside of board
    size = board.board_size
    rows = rows_key(size - 1)
    columns = columns_key(size)

    s_comply = (0..index).map do |idx|
      rows.include?(shot.row) && columns.include?(shot.column)
    end
    if s_comply == false
      puts "The shot cannot be outside the board. Please assign new coordinates"
      s_comply
    end 
  end

end