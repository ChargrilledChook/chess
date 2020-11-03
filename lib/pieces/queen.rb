# Queen

# Represents rook piece. Contains its' allowed movement patterns and icon. Standard / rolling type
class Queen < Piece
  def moves
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]].freeze
  end

  def to_s
    colour == :white ? white_queen : black_queen
  end
end
