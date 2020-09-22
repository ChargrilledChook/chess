require_relative "lib/piece_icons"
require_relative "lib/board"
require_relative "lib/piece"
require_relative "lib/game"
require_relative "lib/king"
#pp Board.new.grid

# game = Game.new(players: %i[white black])

# puts game.players
# game.swap_players
# puts game.players
# game.swap_players

puts King.new.icon
