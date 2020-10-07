class King < Piece
  def moves
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
  end

  # OPTIMISE: See Knight
  def move_list(_board, starting)
    moves.map { |move| [starting.first + move.first, starting.last + move.last] }
  end

  def to_s
    colour == :white ? white_king : black_king
  end
end
