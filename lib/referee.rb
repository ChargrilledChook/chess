require "pry"

class Referee
  attr_reader :white_king, :black_king

  def initialize(board)
    @board = board
    @white_king = board.grid[7][4]
    @black_king = board.grid[0][4]
  end

  def valid_move?(move, board, player)
    starting = move.starting
    ending = move.ending
    save_board_state(starting, ending)
    piece = board[starting.first][starting.last]
    return false unless own_piece?(starting, board, player) && allowed_moves(piece, board, starting).include?(ending)

    true
  end

  # OPTIMIZE: Prototype. Refactor
  def check?(board, player)
    king = select_king(player)
    check = false
    board.each_with_index do |rank, ridx|
      rank.each_index do |file|
        if board[ridx][file].colour == king.enemy_colour
          piece = board[ridx][file]
          check = true if allowed_moves(piece, board, [ridx, file]).include?(king.position)
        end
      end
    end
    # binding.pry
    check
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

  private

  def own_piece?(starting, board, player)
    piece = board[starting.first][starting.last]
    piece.colour == player.colour
  end

  def select_king(player)
    player.colour == :white ? white_king : black_king
  end

  def allowed_moves(piece, board, starting)
    piece.move_list(board, starting)
  end

  def save_board_state(starting, ending)
    @previous_from = @board.grid[starting.first][starting.last]
    @previous_to = @board.grid[ending.first][ending.last]
  end
end
