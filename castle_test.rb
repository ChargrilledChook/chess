module Castle
  def castle_long(grid, colour)
    case colour
    when :white
      grid.place_move(piece_pos[:white_king], piece_to[:w_king_long])
      grid.place_move(piece_pos[:w_long_rook], piece_to[:w_rook_long])
    when :black
      grid.place_move(piece_pos[:black_king], piece_to[:b_king_long])
      grid.place_move(piece_pos[:b_long_rook], piece_to[:b_rook_long])
    end
  end

  def castle_short(grid, colour)
    case colour
    when :white
      grid.place_move(piece_pos[:white_king], piece_to[:w_king_long])
      grid.place_move(piece_pos[:white_king], piece_to[:w_king_long])
    when :black
      grid.place_move(piece_pos[:black_king], piece_to[:b_king_long])
      grid.place_move(piece_pos[:black_king], piece_to[:b_king_long])
    else

    end
  end

  def piece_pos
    { white_king: [7, 4],
      w_long_rook: [7, 0],
      w_short_rook: [7, 7],
      black_king: [0, 4],
      b_long_rook: [0, 0],
      b_short_rook: [0, 7] }
  end

  def piece_to
    { w_king_long: [7, 2],
      w_king_short: [7, 6],
      w_rook_long: [7, 3],
      w_rook_short: [7, 5],
      b_king_long: [0, 2],
      b_king_short: [0, 6],
      b_rook_long: [0, 3],
      b_rook_short: [0, 5] }
  end
end
