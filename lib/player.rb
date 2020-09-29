# Responsible for user input
class Player
  include Display

  attr_reader :colour

  def initialize(colour:)
    @colour = colour
  end

  def input_move #(prompt_msg)
    # Add an argument to pass in type of prompt - default is normal,
    # Otherwise error message / failure - ie empty square, not your piece etc
    print move_prompt_msg
    move = gets.chomp.downcase
    return move if move.match?(/[a-h][1-8][a-h][1-8]/)

    input_move
  end
end
