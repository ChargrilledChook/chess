# Controls gameplay flow
class GameLoop
  attr_reader :round

  def initialize(round)
    @round = round
  end

  # TODO: Does draw console need to be here? Could simplify API
  def play
    round.draw_console
    round.play until round.game_over?
  end
end
