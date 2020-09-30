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

  def convert_notation(notation)
    result = notation.each_char.map.with_index do |elt, idx|
      idx.even? ? convert_column(elt) : convert_row(elt)
    end
    starting = [result[1], result[0]]
    ending = [result[3], result[2]]
    [starting, ending]
  end

  def convert_column(letter)
    letter.tr('a-h', '0-7').to_i
  end

  def convert_row(digit)
    (digit.to_i - 8).abs
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
