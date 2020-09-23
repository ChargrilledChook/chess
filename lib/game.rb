# Controls gameplay flow
class Game
  attr_reader :round

  def initialize(round: nil)
    @round = round
  end

  def new_game
    # TODO
    # Can decide here whether to inject a fresh round or load one
    # @round = load_save || Round.new
    # play
    # play_again
  end

  def play
    round.play until round.gameover?
  end
end
