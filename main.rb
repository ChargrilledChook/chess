require_relative "lib/utilities/display"
require_relative "lib/utilities/colour_patch"
require_relative "lib/utilities/save_manager"
require_relative "lib/utilities/piece_hashes"
require_relative "lib/utilities/empty_square"
require_relative "lib/castling"
require_relative "lib/move"
require_relative "lib/move_tree"
require_relative "lib/board"
require_relative "lib/player"
require_relative "lib/computer_player"
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
  runtime_option = selection == "2" ? SaveManager.load_save : Round.new(player_types: select_player_types)
  GameLoop.new(runtime_option).play
end

def select_player_types
  puts "Select what type of game: "
  puts "1. Human vs Human"
  puts "2. Human vs AI"
  puts "3. AI vs AI"
  type = gets.chomp.downcase
  return type if (1..3).include?(type.to_i)

  select_player_types
end

new_session
