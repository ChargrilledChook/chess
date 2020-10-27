# Experimental class. Since every single move needs to be checked
# every single turn anyway, why not generate it at the start and use it for everything? Perhaps
class MoveTree
  attr_reader :board

  def self.build_tree(board, colour)
    board.grid.each_with_index.flat_map do |line, rank_idx|
      line.each_index.filter_map do |file_idx|
        [rank_idx, file_idx] if board.grid[rank_idx][file_idx].colour == colour
      end
    end
  end

  def self.build_move_lists(board, colour)
    pieces = build_tree(colour)
    pieces.each_with_object({}) do |piece, res|
      res[piece] = board.grid[piece.first][piece.last].move_list(board.grid, [piece.first, piece.last])
    end
  end

  def initialize(board)
    @board = board
  end

  def build_tree(colour)
    board.grid.each_with_index.flat_map do |line, rank_idx|
      line.each_index.filter_map do |file_idx|
        [rank_idx, file_idx] if board.grid[rank_idx][file_idx].colour == colour
      end
    end
  end

  def build_move_lists(colour)
    pieces = build_tree(colour)
    pieces.each_with_object({}) do |piece, res|
      res[piece] = board.grid[piece.first][piece.last].move_list(board.grid, [piece.first, piece.last])
    end
  end

  def convert_to_moves(colour)
    move_list = build_move_lists(colour)
    move_list.flat_map do |key, values|
      values.map { |value| [key, value] }
    end
  end
end
