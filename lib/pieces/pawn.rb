class Pawn
  include PieceIcons

  attr_reader :colour

  def initialize(colour: :white)
    @colour = colour
  end

  def moves
    colour == :white ? [[-1, 0]] : [[1, 0]]
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end
end
