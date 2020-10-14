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

  # OPTIMISE: This code is currently duplicated in King. Probably a better way to deal with nil ranks
  def move_list(board, starting)
    list = moves.map { |move| [starting.first + move.first, starting.last + move.last] }
    list = list.select { |move| valid_move?(board, move) }
    list.reject { |move| check_if_own_colour(board, move) }
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end

  private

  # OPTIMISE: See #move_list
  def valid_move?(board, move)
    move.first.between?(0, board.size) && move.last.between?(0, board.size)
  end

  def check_if_own_colour(board, move)
    board[move.first][move.last].colour == colour
  rescue NoMethodError
    true
  end
end

