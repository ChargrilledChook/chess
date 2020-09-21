require_relative "lib/icons"
require_relative "lib/board"
require_relative "lib/piece"
require_relative "lib/game"

#pp Board.new.grid

rook = Piece.new(colour: 'Black', type: 'Rook')

puts rook.black_rook
puts rook.white_rook
puts rook.white_bishop
puts rook.black_bishop
puts rook.white_knight
puts rook.black_knight
puts rook.white_pawn
puts rook.black_pawn
puts rook.white_queen
puts rook.black_queen
puts rook.white_king
puts rook.black_king
