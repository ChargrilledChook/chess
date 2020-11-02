# A computer controlled player. Not very smart. Picks legal moves randomly.
class ComputerPlayer
  attr_reader :colour, :move_tree, :ai

  def initialize(colour:, board:)
    @colour = colour
    @board = board
    @move_tree = MoveTree.new(board)
    @ai = true
  end

  def input_move
    move_tree.convert_to_moves(colour).sample
  end

  def choose_promotion
    "q"
  end
end
