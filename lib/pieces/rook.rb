class Rook < Piece
  def post_initialize
    @first_move = true
  end

  def moves
    [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze
  end

  def to_s
    colour == :white ? white_rook : black_rook
  end
end
