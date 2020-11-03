# King

# Represents bishop piece. Contains its' allowed movement patterns and icon. Single move type
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

  def move_list(board, starting)
    single_move_list(board, starting)
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
