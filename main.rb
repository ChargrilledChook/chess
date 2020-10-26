require_relative "lib/utilities/display"
require_relative "lib/utilities/colour_patch"
require_relative "lib/utilities/save_manager"
require_relative "lib/utilities/piece_hashes"
require_relative "lib/utilities/empty_square"
require_relative "lib/move"
require_relative "lib/move_tree"
require_relative "lib/board"
require_relative "lib/player"
require_relative "lib/round"
require_relative "lib/game_loop"
require_relative "lib/referee"
require_relative "lib/pieces/piece_icons"
require_relative "lib/pieces/piece"
require_relative "lib/pieces/king"
require_relative "lib/pieces/queen"
require_relative "lib/pieces/rook"
require_relative "lib/pieces/bishop"
require_relative "lib/pieces/knight"
require_relative "lib/pieces/pawn"

def new_session
  puts Display.title_art
  puts Display.welcome_msg
  selection = gets.chomp.downcase
  runtime_option = selection == "2" ? SaveManager.load_save : Round.new
  GameLoop.new(runtime_option).play
end

new_session
