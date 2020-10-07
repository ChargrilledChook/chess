# Domain object prototype
class Piece
  include PieceIcons

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
  end

  # HACK: Inefficent. Needs tests to refactor safely
  def move_list(board, starting)
    res = []
    moves.each do |move|
      begin
        row = starting.first
        col = starting.last
        row += move.first
        col += move.last
        current = board.grid[row][col]
        while valid?(row, col, current)
          res << [row, col]
          row += move.first
          col += move.last
          current = board.grid[row][col] if valid?(row, col, current)
        end
      rescue NoMethodError
        next
      end
    end
    res
  end

  def moves
    raise NotImplementedError
  end

  private

  # HACK: This currently knows too much about board but is fine for now
  def valid?(row, col, current)
    row.between?(0, 7) && col.between?(0, 7) && current == "   "
  end
end
