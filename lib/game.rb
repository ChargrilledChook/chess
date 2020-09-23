# Controls gameplay flow
class Game
  attr_reader :players, :round

  def initialize(players: nil, round: nil)
    @players = players
    @round = round
  end

  def new_game
    # TODO
  end

  def play
    # TODO
    # round.play until round.gameover?
    # puts round.winner
  end

  def swap_players
    @players.rotate!
  end
end
