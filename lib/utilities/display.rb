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

  def self.welcome_msg
    "\nWelcome to Chess! Enter 1 for a new game or 2 to load your saved game. "
  end

  def self.test_welcome_msg
    "\n\t\t \u2655\u2655\u2655 Welcome to Chess! \u2655\u2655\u2655"
  end

  def self.any_key_msg
    "\n\t\t Press ANY KEY to continue"
  end

  def self.menu_msg
    "\u265C Select an option \u265C\n\n1. New Game\n2. Load Saved Game\n3. How To Play"
  end

  def move_prompt_msg
    "\n#{colour.capitalize}, it's your move: "
  end

  def self.clear_console
    puts "\e[H\e[2J"
  end
end
