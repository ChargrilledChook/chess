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
    gets.chomp.downcase
    # Needs to reprompt until in proper notation
  end
end
