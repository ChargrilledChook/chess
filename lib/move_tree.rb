# MoveTree

# Takes a reference to a board and is able to generate several useful adjacency list-like outputs.
# Multiple uses, such as being used by an AI to select moves, and to iterate through possible moves
# to test for checkmate.
class MoveTree
  attr_reader :board

  def initialize(board)
    @board = board
  end

  # Returns an array of the [x, y] co-ordinates of every piece matching the colour param
  def select_pieces(colour)
    board.grid.each_with_index.flat_map do |line, rank_idx|
      line.each_index.filter_map do |file_idx|
        [rank_idx, file_idx] if board.grid[rank_idx][file_idx].colour == colour
      end
    end
  rescue NoMethodError
    # This only exists for replit compatibility. Ruby 2.5 doesn't have #filter_map
    backwards_compat_select_pieces(colour)
  end

  # Creates a hash for every piece of the input colour, with the pieces position as its key,
  # and all its possible ending moves as values.
  def build_move_lists(colour)
    pieces = select_pieces(colour)
    pieces.each_with_object({}) do |piece, res|
      res[piece] = board.grid[piece.first][piece.last].move_list(board.grid, [piece.first, piece.last])
    end
  end

  # Converts a move list hash from a hash to a list of moves that can be input.
  # Formatted as (from [x, y], to [x, y]])
  def convert_to_moves(colour)
    move_list = build_move_lists(colour)
    move_list.flat_map do |key, values|
      values.map { |value| [key, value] }
    end
  end

  # Added for replit compatibility.
  def backwards_compat_select_pieces(colour)
    res = board.grid.each_with_index.flat_map do |line, rank_idx|
      line.each_index.map do |file_idx|
        [rank_idx, file_idx] if board.grid[rank_idx][file_idx].colour == colour
      end
    end
    res.compact
  end
end
