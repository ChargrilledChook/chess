# Controls gameplay flow
class Game
  attr_reader :players

  def initialize(players:)
    @players = players
  end

  def swap_players
    @players.rotate
  end
end
