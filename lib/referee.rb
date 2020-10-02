class Referee
  def initialize
    # TODO
  end

  def valid_move?(move, board, player)
    starting = move.first
    ending = move.last
    return true unless empty_cell?(starting, board) ||
                       !own_piece?(starting, board, player) ||
                       own_piece_collision?(starting, ending, board) ||
                       !allowed_moves(starting, board).include?(ending)
  end

  private

  def empty_cell?(starting, board)
    board.grid[starting.first][starting.last] == board.empty_cell
  end

  def own_piece?(starting, board, player)
    piece = board.grid[starting.first][starting.last]
    piece.colour == player.colour
  end

  def own_piece_collision?(starting, ending, board)
    starting_piece = board.grid[starting.first][starting.last]
    ending_piece = board.grid[ending.first][ending.last]
    return false if ending_piece == board.empty_cell

    starting_piece.colour == ending_piece.colour
  end

  def allowed_moves(piece, board)
    board.grid[piece.first][piece.last].moves.map { |rank, file| [piece.first + rank, piece.last + file] }
  end
end
