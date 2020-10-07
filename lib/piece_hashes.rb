# Hashes of piece setups for the board class
module PieceCollections
  # OPTIMIZE: Should probably break this up into smaller chunks
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
      [7, 7] => Rook.new(colour: :white),
      [6, 0] => Pawn.new(colour: :white),
      [6, 1] => Pawn.new(colour: :white),
      [6, 2] => Pawn.new(colour: :white),
      [6, 3] => Pawn.new(colour: :white),
      [6, 4] => Pawn.new(colour: :white),
      [6, 5] => Pawn.new(colour: :white),
      [6, 6] => Pawn.new(colour: :white),
      [6, 7] => Pawn.new(colour: :white),
      [1, 0] => Pawn.new(colour: :black),
      [1, 1] => Pawn.new(colour: :black),
      [1, 2] => Pawn.new(colour: :black),
      [1, 3] => Pawn.new(colour: :black),
      [1, 4] => Pawn.new(colour: :black),
      [1, 5] => Pawn.new(colour: :black),
      [1, 6] => Pawn.new(colour: :black),
      [1, 7] => Pawn.new(colour: :black) }
  end

  def queens_test
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
end
