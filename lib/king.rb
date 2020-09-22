class King
  include PieceIcons

  attr_reader :colour, :icon

  def initialize(colour: :white)
    @colour = colour
    @icon = white_king # testing only
  end

  def moves
    [[-1, -1],
     [-1, 0],
     [-1, 1],
     [0, -1],
     [0, 1],
     [1, -1],
     [1, 0],
     [1, 1]]
  end
end
