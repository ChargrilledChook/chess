class Referee
  def initialize
    # TODO
  end

  def valid_move?(move, board, player)
    starting = move.starting
    ending = move.ending
    piece = board[starting.first][starting.last]
    own_piece?(starting, board, player) && allowed_moves(piece, board, starting).include?(ending)
  end

  private

  def own_piece?(starting, board, player)
    piece = board[starting.first][starting.last]
    piece.colour == player.colour
  end

  def allowed_moves(piece, board, starting)
    piece.move_list(board, starting)
  end
end
