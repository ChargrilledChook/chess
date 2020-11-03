# Represents king piece. Contains its' allowed movement patterns and icon. Single move type
class King < Piece
  attr_reader :position, :first_move

  def post_initialize
    @position = colour == :white ? [7, 4] : [0, 4]
    @first_move = true
  end

  def move_list(board, starting)
    single_move_list(board, starting)
  end

  def update(_ = nil)
    @first_move = false
  end

  def undo_update
    @first_move = true
  end

  def king?
    true
  end

  def to_s
    colour == :white ? white_king : black_king
  end

  private

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
end
