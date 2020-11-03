# A computer controlled player. Not very smart. Picks legal moves randomly.
# Uses the MoveTree object to generate its moves, so it needs a reference to
# the board object.
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

  # Computer will always choose a Queen
  def choose_promotion
    "q"
  end
end
