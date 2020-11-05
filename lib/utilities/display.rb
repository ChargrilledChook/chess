# Module for strings and text content
module Display
  def self.title_art
    <<~HERE

      ▄████████    ▄█    █▄       ▄████████    ▄████████    ▄████████
      ███    ███   ███    ███     ███    ███   ███    ███   ███    ███
      ███    █▀    ███    ███     ███    █▀    ███    █▀    ███    █▀
      ███         ▄███▄▄▄▄███▄▄  ▄███▄▄▄       ███          ███
      ███        ▀▀███▀▀▀▀███▀  ▀▀███▀▀▀     ▀███████████ ▀███████████
      ███    █▄    ███    ███     ███    █▄           ███          ███
      ███    ███   ███    ███     ███    ███    ▄█    ███    ▄█    ███
      ████████▀    ███    █▀      ██████████  ▄████████▀   ▄████████▀


    HERE
  end

  def self.test_welcome_msg
    "\n\t\t \u2655\u2655\u2655 Welcome to Chess! \u2655\u2655\u2655"
  end

  def self.any_key_msg
    "\n\t\t Press #{'ENTER'.bold.green} to continue"
  end

  def self.menu_msg
    "\u265C #{'Select an option'.bold.blue} \u265C\n\n1. New Game\n2. Load Saved Game\n3. How To Play"
  end

  def self.clear_console
    puts "\e[H\e[2J"
  end

  def self.rules_msg
    <<~HEREDOC
      #{'HOW TO PLAY'.bold.blue}

      This game uses algerbraic chess notation to input moves. Select the square you want to move from, and the square you want to
      move to. For instance:  a1h8
                              c5f3
                              d4g6

      En passant moves are entered with standard notation, with your pawns ending point as the destination.

      Letters must be between a - h and numbers between 1 - 8.


      #{'COMMANDS'.bold.blue}

      Aside from chess notation, there are several commands available to you in game.

      #{'CASTLE'.bold.green}  - You will be prompted to select [l/r] for castling left or right. Will perform the move if legal.
               A legal castle is not castling into, out of or through check. The rook and the king must not have
               moved, and the spaces between them must be empty.

      #{'HELP'.bold.green}   - Will display this screen in game.

      #{'SAVE'.bold.green}   - Save and exit the game. Select load game from the main menu to load your save.

      #{'EXIT'.bold.green}   - Exit the game without saving.


      #{'VISUALS'.bold.blue}

      The appearance and colours of the pieces and board depend on your system and console settings.
      On your device, pieces will look like this:


               #{'P R B N Q K'.bold.green}

      WHITE => \u2659 \u2656 \u2657 \u2658 \u2655 \u2654

      BLACK => \u265F \u265C \u265D \u265E \u265B \u265A


      #{'RULES OF CHESS'.bold.blue}

      If you require more detailed rules about the game of chess, please visit #{'https://www.chess.com/lessons'.bold.green}

      Press #{'ENTER'.bold.green} to continue
    HEREDOC
  end

  def self.player_select_msg
    <<~HEREDOC
      \u265C #{'Select what type of game:'.bold.blue} \u265C

      1. Human vs Human
      2. Human vs AI
      3. AI vs Human
      4. AI vs AI
    HEREDOC
  end

  def self.play_again_msg
    "\nPlay again? [Y/n] : "
  end

  def self.thanks_exit_msg
    "\nThanks for playing!"
  end

  def help_msg
    "\n#{'Type HELP for commands'.blue}\n"
  end

  def move_prompt_msg
    "\n#{colour.capitalize}, it's your move: "
  end

  def thanks_exit_msg
    "\nThanks for playing!"
  end

  def promotion_msg
    "\nSelect your shiny new piece [Q/K/R/B] :  "
  end

  def player_selection_error_msg
    "\nSomething went wrong when initialising players. Please try again."
  end

  def keywords
    %w[save castle exit help]
  end

  def en_passant_error
    "Unfortunately this move breaks the game because you put yourself in check. I'm working on a fix!"
  end
end
