# Controls gameplay flow
class GameLoop
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def play
    round.draw_console
    round.play until round.game_over?
  end
end
