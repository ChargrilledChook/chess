class King < Piece
  attr_reader :position

  def post_initialize
    @position = colour == :white ? [7, 4] : [0, 4]
  end

  # OPTIMISE: See Knight
  def move_list(board, starting)
    list = moves.map { |move| [starting.first + move.first, starting.last + move.last] }
    list.select { |move| valid_move?(board, move) && !friend?(board, move) }
  end

  def update(pos)
    @previous_pos = @position
    @position = pos
  end

  def undo_update
    @position = @previous_pos
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
     [1, 1]]
  end
end
