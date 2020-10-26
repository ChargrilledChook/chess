class Knight < Piece
  def moves
    [[2, -1],
     [-2, 1],
     [-2, -1],
     [2, 1],
     [1, -2],
     [-1, 2],
     [-1, -2],
     [1, 2]].freeze
  end

  # OPTIMISE: This code is currently duplicated in King.
  def move_list(board, starting)
    list = moves.map { |move| [starting.first + move.first, starting.last + move.last] }
    list.select { |move| valid_move?(board, move) && !friend?(board, move) }
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
