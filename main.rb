require_relative "lib/utilities/display"
require_relative "lib/utilities/colour_patch"
require_relative "lib/utilities/save_manager"
require_relative "lib/utilities/piece_hashes"
require_relative "lib/utilities/empty_square"
require_relative "lib/utilities/castling"
require_relative "lib/utilities/player_types"
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
  menu
  play_again
end

def play_again
  print Display.play_again_msg
  choice = gets.chomp.downcase
  choice == "y" ? new_session : puts(Display.thanks_exit_msg)
end

def title
  puts Display.title_art
  puts Display.test_welcome_msg
  puts Display.any_key_msg
  gets
end

def menu
  Display.clear_console
  puts Display.menu_msg
  choice = gets.chomp
  case choice
  when "1" then select_runtime("1")
  when "2" then select_runtime("2")
  when "3" then rules
  else menu
  end
end

def select_player_types
  puts Display.player_select_msg
  type = gets.chomp.downcase
  return type if (1..4).include?(type.to_i)

  select_player_types
end

def rules
  puts Display.rules_msg
  gets
  menu
end

def select_runtime(option)
  runtime = option == "2" ? SaveManager.load_save : Round.new(player_types: select_player_types)
  GameLoop.new(runtime).play
end

title
new_session
