class Knight
  include PieceIcons

  attr_reader :colour

  def initialize(colour: :white)
    @colour = colour
  end

  def moves
    [[2, -1],
     [-2, 1],
     [-2, -1],
     [2, 1],
     [1, -2],
     [-1, 2],
     [-1, -2],
     [1, 2]]
  end

  def to_s
    colour == :white ? white_knight : black_knight
  end
end
