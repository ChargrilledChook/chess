class Referee
  def initialize
    # TODO
  end

  def valid_move?(move, board, player)
    starting = move.starting
    ending = move.ending
    piece = board[starting.first][starting.last]
    return false unless own_piece?(starting, board, player) && allowed_moves(piece, board, starting).include?(ending)

    #check?(board, [7, 4]) == false
  end

  private

  def own_piece?(starting, board, player)
    piece = board[starting.first][starting.last]
    piece.colour == player.colour
  end

  def allowed_moves(piece, board, starting)
    piece.move_list(board, starting)
  end

  # TODO: Currently untested and unimplemented, just gathering thoughts
  # HACK: Prototype. Should break immediately upoun finding a check to optimize
  def check?(board, king_pos)
    check = false
    king = board[king_pos.first][king_pos.last]
    board.each_with_index do |rank, ridx|
      rank.each_index do |file|
        if board[ridx][file].colour == king.enemy_colour
          piece = board[ridx][file]
          check = true if allowed_moves(piece, board, [ridx, file]).include?(king_pos)
        end
      end
    end
    check
  end
end
