# Controls gameplay flow
class GameLoop
  attr_reader :round

  def initialize(round)
    @round = round
  end

  # TODO: Does draw console need to be here? Could simplify API
  def play
    round.boot_game
    round.play until game_over?
    post_game
  end

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
