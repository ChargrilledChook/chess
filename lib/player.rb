# Player

# Responsible for human players and getting their input. Manages inputing moves, system commands
# and selecting pawn promotion.
class Player
  include Display

  attr_reader :colour, :ai

  def initialize(colour:)
    @colour = colour
    @ai = false
  end

  # Keywords can be found within the display module
  def input_move
    move = user_input
    return move if keywords.include?(move)

    Move.new(move).data
  end

  # TODO: These two names (this and above) are slightly ambiguous. Differentiate
  def user_input
    print move_prompt_msg
    move = gets.chomp.downcase
    return move if valid_input?(move)

    user_input
  end

  def valid_input?(input)
    input.downcase.match?(/^[a-h][1-8][a-h][1-8]$/) || keywords.include?(input.downcase)
  end

  def choose_promotion
    print promotion_msg
    gets.chomp.downcase[0]
  end
end
