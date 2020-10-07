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

  def move_list
    moves
  end

  def to_s
    colour == :white ? white_king : black_king
  end
end
