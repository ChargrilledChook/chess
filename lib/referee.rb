# Responsible for enforcing (most) of the rules of chess, in particular it can assess
# whether a player is in check, checkmate or a stalemate. Also checks if individual moves are legal
# Utilises the MoveTree to build graphs for checkmate.
# Is possibly doing too much and should be broken down into slightly smaller objects.
class Referee
  attr_reader :move_tree, :board

  def initialize(board)
    @board = board
    @move_tree = MoveTree.new(board)
  end

  # Checks if a piece is owned by the player attempting to move it,
  # and that the piece type can move that way.
  def valid_move?(move, player)
    moves = move_tree.build_move_lists(player.colour)
    starting = move.first
    ending = move.last
    save_board_state(starting, ending)
    return false unless moves.fetch(starting, []).include?(ending)

    true
  end

  # Simulates a move, then sees if the resulting board state puts the moving player in check.
  # Resets the board to original state afterwards
  def attempt_move(move, current_player)
    save_board_state(move.first, move.last)
    board.place_move(move.first, move.last)
    check = check?(current_player)
    restore_board(move.first, move.last)
    check
  end

  def check?(player)
    king_pos = find_king_pos(player.colour)
    king = board.grid[king_pos.first][king_pos.last]
    moves = move_tree.build_move_lists(king.enemy_colour)
    moves.values.any? { |ending| ending.include?(king_pos) }
  end

  def checkmate?(current_player)
    return false unless check?(current_player)

    iterate_over_moves(current_player)
  end

  def stalemate?(players)
    blocked_stalemate(players.first) || kings_only_stalemate(players)
  end

  def restore_board(starting, ending)
    @board.grid[starting.first][starting.last] = @previous_from
    @board.grid[ending.first][ending.last] = @previous_to
  end

  private

  def save_board_state(starting, ending)
    @previous_from = @board.grid[starting.first][starting.last]
    @previous_to = @board.grid[ending.first][ending.last]
  end

  def blocked_stalemate(current_player)
    return false if check?(current_player)

    iterate_over_moves(current_player)
  end

  def kings_only_stalemate(players)
    move_tree.select_pieces(players.first.colour).size == 1 && move_tree.select_pieces(players.last.colour).size == 1
  end

  def iterate_over_moves(current_player)
    moves = move_tree.convert_to_moves(current_player.colour)
    moves.all? do |from, to|
      attempt_move([from, to], current_player)
    end
  end

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
