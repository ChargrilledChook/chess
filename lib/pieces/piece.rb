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

  private

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
