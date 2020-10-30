# A computer controlled player. Not very smart. Picks legal moves randomly.
class ComputerPlayer
  attr_reader :colour, :move_tree, :ai

  def initialize(colour:, board:, move_tree:)
    @colour = colour
    @board = board
    @move_tree = move_tree
    @ai = true
  end

  def input_move
    move_tree.convert_to_moves(colour).sample
  end

  def choose_promotion
    "q"
  end
end
