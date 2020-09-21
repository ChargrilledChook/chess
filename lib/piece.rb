# Domain object prototype
class Piece
  attr_reader :colour, :type

  def initialize(colour:, type:, icon:)
    @colour = colour
    @type = type
    @icon = icon
  end

  def move; end

  def to_s
    "A #{colour} #{type}"
  end
end
