# Co-ordinates collaborating objects to play a single round of chess
class Round
  attr_reader :players, :board, :ref

  def initialize(players: nil, board: nil, ref: nil)
    @players = players
    @board = board
    @ref = ref
  end

  def swap_players
    @players.rotate!
  end
end
