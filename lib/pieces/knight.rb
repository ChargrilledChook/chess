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

  def move_list
    moves
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
