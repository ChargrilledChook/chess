# Co-ordinates collaborating objects to play a single round of chess
class Round
  include SaveManager

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
    move = check_move
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

  # shit name
  def check_move
    move = players.first.input_move
    save_game(self) if move == "save"
    move = ref.convert_notation(move)
    return move if ref.valid_move?(move, board, players.first)

    check_move
  end

  def clear_console
    puts "\e[H\e[2J"
  end
end
