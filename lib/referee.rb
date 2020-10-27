class Referee
  attr_reader :white_king, :black_king, :move_tree

  def initialize(board)
    @board = board
    @white_king = board.grid[7][4]
    @black_king = board.grid[0][4]
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
    king = select_king(player)
    moves = move_tree.build_move_lists(king.enemy_colour)
    moves.values.any? { |ending| ending.include?(king.position) }
  end

  # TODO
  def checkmate?(_board, _player)
    false
  end

  # TODO
  def stalemate?(_board, _player)
    false
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

  def select_king(player)
    player.colour == :white ? white_king : black_king
  end

  # TODO: Being used by check but can be factored out with new move list
  def allowed_moves(piece, board, starting)
    piece.move_list(board, starting)
  end
end
