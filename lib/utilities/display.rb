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

  def move_prompt_msg
    "\n#{colour.capitalize}, it's your move: "
  end
end
