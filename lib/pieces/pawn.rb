class Pawn < Piece
  attr_reader :first_move

  def initialize(colour: :white)
    @colour = colour
  end

  def post_initialize
    @first_move = true
  end

  def moves
    if first_move
      colour == :white ? [[-1, 0], [-2, 0]] : [[1, 0], [2, 0]]
      self.first_move = false
    else
      colour == :white ? [[-1, 0]] : [[1, 0]]
    end
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end

  # TODO: This is currently not connected to anything. Need to figure out how to integrate with move list in super
  def attack
    case colour
    when :white
      [[-1, -1], [-1, 1]]
    when :black
      [[1, -1], [1, 1]]
    end
  end
end
