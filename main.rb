require_relative "lib/board"
require_relative "lib/piece"

pp Board.new.grid

puts Piece.new(colour: 'White', type: 'Rook')
