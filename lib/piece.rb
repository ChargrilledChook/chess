# Domain object prototype
class Piece
  attr_reader :colour, :type

  def initialize(colour:, type:)
    @colour = colour
    @type = type
  end

  def move; end

  def to_s
    "A #{colour} #{type}"
  end
end
