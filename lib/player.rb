# Responsible for user input
class Player
  include Display

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
  end

  def input_move
    # TODO
    print move_prompt_msg
    gets.chomp.chars
  end
end
