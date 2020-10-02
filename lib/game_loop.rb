# Controls gameplay flow
class GameLoop
  include SaveManager

  attr_reader :round

  def initialize
    @round = new_session
  end

  def new_session
    # TODO: Extract string to display and polish implementation
    puts "Welcome to Chess. Enter 1 for a new game or 2 to load your saved game."
    selection = gets.chomp.downcase
    selection == "2" ? load_save : Round.new
  end

  def play
    round.draw_console
    round.play until round.game_over?
  end
end
