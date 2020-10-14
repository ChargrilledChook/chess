class King < Piece
  def moves
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
  end

  # OPTIMISE: See Knight
  def move_list(board, starting)
    list = moves.map { |move| [starting.first + move.first, starting.last + move.last] }
    list = list.select { |move| valid_move?(board, move) }
    list.reject do |move|
      begin
        board[move.first][move.last].colour == colour
      rescue NoMethodError
        true
      end
    end
  end

  def to_s
    colour == :white ? white_king : black_king
  end

  private

  # OPTIMISE: See #move_list
  def valid_move?(board, move)
    move.first.between?(0, board.size) && move.last.between?(0, board.size)
  end

  # TODO: In progress
  def on_board?(move)
    begin
      board[move.first][move.last].colour == colour
    rescue NoMethodError
      true
    end
  end
end

