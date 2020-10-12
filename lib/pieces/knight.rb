class Knight < Piece
  def moves
    [[2, -1],
     [-2, 1],
     [-2, -1],
     [2, 1],
     [1, -2],
     [-1, 2],
     [-1, -2],
     [1, 2]]
  end

  # OPTIMISE: This code is currently duplicated in King. Probably a better way to deal with nil ranks
  def move_list(board, starting)
    list = moves.map { |move| [starting.first + move.first, starting.last + move.last] }
    list.reject do |move|
      begin
        board.grid[move.first][move.last].colour == colour
      rescue NoMethodError
        true
      end
    end
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
