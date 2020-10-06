class Rook
  include PieceIcons

  MOVES = [[1, 0], [-1, 0], [0, 1], [0, -1]].freeze

  attr_reader :colour

  def initialize(colour: :white)
    @colour = colour
  end

  def move_list(board, starting)
    res = []
    MOVES.each do |move|
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

  def to_s
    colour == :white ? white_rook : black_rook
  end

  private

  def valid?(row, col, current)
    row.between?(0, 7) && col.between?(0, 7) && current == "   "
  end
end
