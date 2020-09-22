require_relative "lib/icons"
require_relative "lib/board"
require_relative "lib/piece"
require_relative "lib/game"

#pp Board.new.grid

game = Game.new([:white, :black])

puts game.players
game.swap_players
puts game.players
