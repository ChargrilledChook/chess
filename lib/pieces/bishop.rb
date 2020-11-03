# Bishop

# Represents bishop piece. Contains its' allowed movement patterns and icon. Standard / rolling type
class Bishop < Piece
  def moves
    [[1, 1], [1, -1], [-1, -1], [-1, 1]].freeze
  end

  def to_s
    colour == :white ? white_bishop : black_bishop
  end
end
