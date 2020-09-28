class Pawn
  include PieceIcons

  attr_reader :colour

  def initialize(colour: :white)
    @colour = colour
  end

  def moves
    # TODO
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end
end
