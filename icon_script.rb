require_relative "lib/piece_icons"
require_relative "lib/board"
require_relative "lib/piece"
require_relative "lib/game"

# Used for testing early on. Probably uneccessary now

rook = Piece.new(colour: 'Black', type: 'Rook')

puts rook.white_rook
puts rook.black_rook
puts
puts rook.white_bishop
puts rook.black_bishop
puts
puts rook.white_knight
puts rook.black_knight
puts
puts rook.white_pawn
puts rook.black_pawn
puts
puts rook.white_queen
puts rook.black_queen
puts
puts rook.white_king
puts rook.black_king
