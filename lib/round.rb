# Co-ordinates collaborating objects to play a single round of chess
class Round
  attr_reader :players, :board, :ref

  def initialize(
    players: [Player.new(colour: :white), Player.new(colour: :black)],
    board: Board.new,
    ref: Referee.new
  )

    @players = players
    @board = board
    @ref = ref
  end

  def play
    # TODO: In progress
    move = players.first.input_move
    move = ref.convert_notation(move)
    board.place_move(move)
    clear_console
    draw_console
    swap_players
  end

  def game_over?
    # TODO
    false
  end

  def draw_console
    # TODO: Add move history, taken pieces, menu etc
    board.render_board
  end

  def swap_players
    @players.rotate!
  end

  private

  def clear_console
    puts "\e[H\e[2J"
  end
end
