# Co-ordinates collaborating objects to play a single round of chess
class Round
  attr_reader :players, :board, :ref

  def initialize(
    players: nil, # [Player.new(:white), Player.new(:black)]
    board: nil,   # Board.new
    ref: nil      # Ref.new
  )

    @players = players
    @board = board
    @ref = ref
  end

  def swap_players
    @players.rotate!
  end
end
