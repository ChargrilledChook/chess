# Domain object prototype
class Piece
  include PieceIcons

  attr_reader :colour, :type, :icon

  def initialize(colour:, type:, icon: black_rook)
    @colour = colour
    @type = type
    @icon = icon
  end

  def move; end

  def to_s
    "A #{colour} #{type}"
  end
end
