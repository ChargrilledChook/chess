class Referee
  attr_reader :move_tree, :board

  def initialize(board)
    @board = board
    @move_tree = MoveTree.new(board)
  end

  def valid_move?(move, player)
    moves = move_tree.build_move_lists(player.colour)
    starting = move.first
    ending = move.last
    save_board_state(starting, ending)
    return false unless moves.fetch(starting, []).include?(ending)

    true
  end

  # need to memoize build_moves somehow?
  def check?(player)
    king_pos = find_king_pos(player.colour)
    king = board.grid[king_pos.first][king_pos.last]
    moves = move_tree.build_move_lists(king.enemy_colour)
    moves.values.any? { |ending| ending.include?(king_pos) }
  end

  def restore_board(starting, ending)
    @board.grid[starting.first][starting.last] = @previous_from
    @board.grid[ending.first][ending.last] = @previous_to
  end

  def save_board_state(starting, ending)
    @previous_from = @board.grid[starting.first][starting.last]
    @previous_to = @board.grid[ending.first][ending.last]
  end

  private

  # OPTIMISE: Very inefficient
  def find_king_pos(colour)
    res = board.grid.each_with_index.flat_map do |line, rank_idx|
      line.each_index.map do |file_idx|
        [rank_idx, file_idx] if correct_king?(rank_idx, file_idx, colour)
      end
    end
    res.compact.flatten
  end

  def correct_king?(rank_idx, file_idx, colour)
    board.grid[rank_idx][file_idx].king? && board.grid[rank_idx][file_idx].colour == colour
  end
end
