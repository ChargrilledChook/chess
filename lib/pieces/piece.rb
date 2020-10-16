# Domain object prototype
class Piece
  include PieceIcons

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
    post_initialize
  end

  # This is a hook method that can be overridden by children. Currently only needed for pawns.
  def post_initialize; end

  # HACK: Inefficent and ugly. Needs tests to refactor safely. It's possible some of these calculations
  # ie not being able to move through another piece don't belong here at all. This method may know too
  # much about other objects
  def move_list(board, starting)
    res = []
    moves.each do |move|
      begin
        row = starting.first + move.first
        col = starting.last + move.last
        while open_square?(board, [row, col])
          res << [row, col]
          row += move.first
          col += move.last
        end
        res << open_attack(board, row, col)
      rescue NoMethodError
        next
      end
    end
    res.compact
  end

  def moves
    raise NotImplementedError
  end

  def enemy_colour
    colour == :white ? :black : :white
  end

  private

  def open_square?(board, move)
    valid_move?(board, move) && empty?(board, move)
  end

  def open_attack(board, row, col)
    [row, col] if board[row][col].colour == enemy_colour
  end

  def valid_move?(board, move)
    move.first.between?(0, board.size) && move.last.between?(0, board.size)
  end

  def enemy?(board, move)
    board[move.first][move.last].colour == enemy_colour
  rescue NoMethodError
    false
  end

  def empty?(board, move)
    board[move.first][move.last].colour == :none
  rescue NoMethodError
    false
  end

  def friend?(board, move)
    board[move.first][move.last].colour == colour
  rescue NoMethodError
    true
  end
end
