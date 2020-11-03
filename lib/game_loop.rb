# GameLoop

# Controls gameplay flow. Loops the game till it's over then prints the appropriate victory /
# stalemate message. The main advantage of having a small looping class like this is that we
# can inject a round object, which holds all data for gamestate. This allows for loading
# saved game or preset board states.
class GameLoop
  attr_reader :round

  def initialize(round)
    @round = round
  end

  def play
    round.boot_game
    round.play until game_over?
    post_game
  end

  # TODO: Extract strings to display
  def post_game
    if round.checkmate?
      puts "\n#{round.players.last.colour.capitalize} wins by checkmate!"
    elsif round.stalemate?
      puts "\nStalemate!"
    else
      puts "Whoops, something went wrong."
    end
  end

  private

  def game_over?
    round.checkmate? || round.stalemate?
  end
end
