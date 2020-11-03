# Super class for various piece implementations. Contains a post initilize hook
# that subclasses can optionally implement. Main logic contained here is for the
# two different types of movement patterns - single (knight and king) and rolling / standard
# (Queen, rook, bishop - pieces who can move multiple squares along a plane.)
class Piece
  include PieceIcons

  attr_reader :colour, :passable

  def initialize(colour:)
    @colour = colour
    @passable = false
    post_initialize
  end

  # This is a hook method that can be overridden by children. Currently only needed for pawns.
  def post_initialize; end

  # Main movevement implementation for queen, rook and bishop. Takes a board and a starting position
  # and generates a list of positions the piece can move to. Checks for capturing, friendly pieces,
  # and being off the board, but not game state legality (ie check etc)
  def move_list(board, starting)
    moves.each_with_object([]) do |move, res|
      pos = update_pos(move, starting)
      while open_square?(board, pos)
        res << pos
        pos = update_pos(move, pos)
      end
      res << open_attack(board, pos) if open_attack(board, pos) && valid_move?(board, pos)
    end
  end

  def enemy_colour
    colour == :white ? :black : :white
  end

  def promotable?(_)
    false
  end

  def update(_); end

  def undo_update; end

  def king?
    false
  end

  def passer?
    false
  end

  private

  # Alternate move list implementation for king and knight
  def single_move_list(board, starting)
    list = moves.map { |move| [starting.first + move.first, starting.last + move.last] }
    list.select { |move| valid_move?(board, move) && !friend?(board, move) }
  end

  def moves
    raise NotImplementedError
  end

  def update_pos(move, pos)
    [move.first + pos.first, move.last + pos.last]
  end

  def valid_move?(board, move)
    move.first.between?(0, board.size - 1) && move.last.between?(0, board.size - 1)
  end

  def open_square?(board, move)
    valid_move?(board, move) && empty?(board, move)
  end

  def open_attack(board, pos)
    [pos.first, pos.last] if board[pos.first][pos.last].colour == enemy_colour
  rescue NoMethodError
    false
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
