# Responsible for user input
class Player
  include Display

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
  end

  # HACK: Refactor. Not awful but could be more robust.
  # Currently looks if the first 4 digits are valid notation, or a keyword
  # May need to add an argument to pass in type of prompt - default is normal,
  # Otherwise error message / failure - ie empty square, not your piece etc
  def input_move
    print move_prompt_msg
    move = gets.chomp.downcase
    return move if move[0..3].match?(/[a-h][1-8][a-h][1-8]/) || move == "save"

    input_move
  end
end
