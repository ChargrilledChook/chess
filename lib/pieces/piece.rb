# Domain object prototype
class Piece
  include PieceIcons

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
  end

  def move
    raise NotImplementedError
  end
end
