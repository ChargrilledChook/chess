module Castle
  Castle = Struct.new(:king_from, :king_to, :rook_from, :rook_to, :empties)

  def white_short
    Castle.new([7, 4], [7, 6], [7, 7], [7, 5], [[7, 5], [7, 6]])
  end

  def pick_castle_type
    white_short
  end

  def castle_round
    moves = pick_castle_type
    return false unless can_castle?(moves)

    backup = board.dup
    castle_moves_simple(moves)
    if ref.check?(players.first)
      reset_board(backup) # need to undo updates on pieces too
    else
      end_round
    end
  end

  def can_castle?(moves)
    king = board.grid[moves.king_from.first][moves.king_from.last]
    rook = board.grid[moves.rook_from.first][moves.rook_from.last]
    return false unless rook.first_move && king.first_move
    return false if ref.check?(players.first)
    return false unless squares_empty?(moves.empties)

    true
  end

  def reset_board(backup)
    self.board = backup
  end

  def castle_moves_simple(moves)
    board.place_move([moves.king_from.first, moves.king_from.last], [moves.king_to.first, moves.king_to.last])
    king = board.grid[moves.king_to.first][moves.king_to.last]
    king.update([moves.king_to.first, moves.king_to.last])
    board.place_move([moves.rook_from.first, moves.rook_from.last], [moves.rook_to.first, moves.rook_to.last])
  end


  def castle_moves(moves, player)
    moves.none? do |move|
      board.place_move(move.first, move.last)
      ref.check?(player)
    end
  end

  def squares_empty?(_type)
    board.grid[7][5].colour == :none && board.grid[7][6].colour == :none
  end

  # def white_short
  #   [[[7, 4], [7, 5]], [[7, 5], [7, 6]], [[7, 7], [7, 5]]]
  # end


end
