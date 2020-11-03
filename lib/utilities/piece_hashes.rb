# Hashes of piece setups for the board class. To add new hashes,
# use the desired board co-ordinates as the key, and the desired piece
# as the value. The board object has a method to convert hashes in this form.
module PieceCollections
  def default_pieces
    black = big_black_pieces.merge(black_pawns)
    white = big_white_pieces.merge(white_pawns)
    black.merge(white)
  end

  def big_black_pieces
    { [0, 0] => Rook.new(colour: :black),
      [0, 2] => Bishop.new(colour: :black),
      [0, 1] => Knight.new(colour: :black),
      [0, 3] => Queen.new(colour: :black),
      [0, 4] => King.new(colour: :black),
      [0, 5] => Bishop.new(colour: :black),
      [0, 6] => Knight.new(colour: :black),
      [0, 7] => Rook.new(colour: :black) }
  end

  def big_white_pieces
    { [7, 0] => Rook.new(colour: :white),
      [7, 1] => Knight.new(colour: :white),
      [7, 2] => Bishop.new(colour: :white),
      [7, 3] => Queen.new(colour: :white),
      [7, 4] => King.new(colour: :white),
      [7, 5] => Bishop.new(colour: :white),
      [7, 6] => Knight.new(colour: :white),
      [7, 7] => Rook.new(colour: :white) }
  end

  def black_pawns
    { [1, 0] => Pawn.new(colour: :black),
      [1, 1] => Pawn.new(colour: :black),
      [1, 2] => Pawn.new(colour: :black),
      [1, 3] => Pawn.new(colour: :black),
      [1, 4] => Pawn.new(colour: :black),
      [1, 5] => Pawn.new(colour: :black),
      [1, 6] => Pawn.new(colour: :black),
      [1, 7] => Pawn.new(colour: :black) }
  end

  def white_pawns
    { [6, 0] => Pawn.new(colour: :white),
      [6, 1] => Pawn.new(colour: :white),
      [6, 2] => Pawn.new(colour: :white),
      [6, 3] => Pawn.new(colour: :white),
      [6, 4] => Pawn.new(colour: :white),
      [6, 5] => Pawn.new(colour: :white),
      [6, 6] => Pawn.new(colour: :white),
      [6, 7] => Pawn.new(colour: :white) }
  end

  def stalemate_test
    { [0, 4] => King.new(colour: :black),
      [7, 4] => King.new(colour: :white),
      [6, 3] => Rook.new(colour: :white),
      [1, 7] => Rook.new(colour: :white),
      [6, 5] => Rook.new(colour: :white) }
  end

  def castle_test
    { [7, 0] => Rook.new(colour: :white),
      [0, 0] => Rook.new(colour: :black),
      [7, 3] => Queen.new(colour: :white),
      [7, 4] => King.new(colour: :white),
      [0, 3] => Queen.new(colour: :black),
      [0, 4] => King.new(colour: :black),
      [0, 7] => Rook.new(colour: :black),
      [7, 7] => Rook.new(colour: :white) }
  end

  def en_passant_test
    { [7, 7] => King.new(colour: :black),
      [3, 0] => King.new(colour: :white),
      [3, 1] => Pawn.new(colour: :white),
      [1, 2] => Pawn.new(colour: :black),
      [3, 3] => Queen.new(colour: :black),
      [6, 0] => Queen.new(colour: :white) }
  end
end
