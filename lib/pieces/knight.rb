class Knight < Piece
  def moves
    [[2, -1],
     [-2, 1],
     [-2, -1],
     [2, 1],
     [1, -2],
     [-1, 2],
     [-1, -2],
     [1, 2]]
  end

  # OPTIMISE: Unused params to be compatible with other pieces. Probably a better way to do this
  def move_list(_board, starting)
    moves.map { |move| [starting.first + move.first, starting.last + move.last] }
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
