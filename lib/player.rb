# Responsible for user input
class Player
  include Display

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
  end

  # HACK: Refactor. Not awful but could be more robust.
  # May need to add an argument to pass in type of prompt - default is normal,
  # Otherwise error message / failure - ie empty square, not your piece etc
  def input_move
    print move_prompt_msg
    move = gets.chomp.downcase
    return move if valid_input?(move)

    input_move
  end

  def format_move
    Move.new(input_move)
  end

  def valid_input?(input)
    input.downcase.match?(/^[a-h][1-8][a-h][1-8]$/) || input.downcase == "save"
  end
end
