class Knight
  include PieceIcons

  attr_reader :colour

  def initialize(colour: :white)
    @colour = colour
  end

  def moves
    # TODO
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
