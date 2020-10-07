# Hashes of piece setups for the board class
module PieceCollections
  def default_pieces
    { [0, 0] => Rook.new(colour: :black),
      [0, 1] => Bishop.new(colour: :black),
      [0, 2] => Knight.new(colour: :black),
      [0, 3] => Queen.new(colour: :black),
      [0, 4] => King.new(colour: :black),
      [0, 5] => Knight.new(colour: :black),
      [0, 6] => Bishop.new(colour: :black),
      [0, 7] => Rook.new(colour: :black),
      [7, 0] => Rook.new(colour: :white),
      [7, 1] => Bishop.new(colour: :white),
      [7, 2] => Knight.new(colour: :white),
      [7, 3] => Queen.new(colour: :white),
      [7, 4] => King.new(colour: :white),
      [7, 5] => Knight.new(colour: :white),
      [7, 6] => Bishop.new(colour: :white),
      [7, 7] => Rook.new(colour: :white) }
  end

  def queens_test
    { [0, 3] => Queen.new(colour: :black),
      [7, 3] => Queen.new(colour: :white) }
  end
end
