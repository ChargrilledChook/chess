require_relative "lib/display"
require_relative "lib/notation_converter"
require_relative "lib/colour_patch"
require_relative "lib/save_manager"
require_relative "lib/piece_hashes"
require_relative "lib/move"
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
  # TODO: Extract string to display and polish implementation

  puts <<~HERE

    ▄████████    ▄█    █▄       ▄████████    ▄████████    ▄████████
    ███    ███   ███    ███     ███    ███   ███    ███   ███    ███
    ███    █▀    ███    ███     ███    █▀    ███    █▀    ███    █▀
    ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄       ███          ███
    ███        ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀     ▀███████████ ▀███████████
    ███    █▄    ███    ███     ███    █▄           ███          ███
    ███    ███   ███    ███     ███    ███    ▄█    ███    ▄█    ███
    ████████▀    ███    █▀      ██████████  ▄████████▀   ▄████████▀


  HERE
  puts "\nWelcome to Chess! Enter 1 for a new game or 2 to load your saved game. "
  selection = gets.chomp.downcase
  selection = selection == "2" ? SaveManager.load_save : Round.new
  GameLoop.new(selection).play
end

new_session
