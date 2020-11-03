# Rook

# Represents rook piece. Contains its' allowed movement patterns and icon. Standard / rolling type
class Rook < Piece
  attr_reader :first_move

  def post_initialize
    @first_move = true
  end

  def moves
    [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze
  end

  def update(_ = nil)
    @first_move = false
  end

  def undo_update
    @first_move = true
  end

  def to_s
    colour == :white ? white_rook : black_rook
  end
end
