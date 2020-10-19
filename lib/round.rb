# Co-ordinates collaborating objects to play a single round of chess
class Round
  include SaveManager
  include NotationConverter
  include PieceCollections

  attr_reader :players, :board, :ref

  def initialize(
    players: [Player.new(colour: :white), Player.new(colour: :black)],
    board: Board.new(default_pieces),
    ref: Referee.new
  )

    @players = players
    @board = board
    @ref = ref
  end

  def play
    move = check_move
    board.place_move(move.starting, move.ending)
    post_move_update(move.ending)
    clear_console
    draw_console
    swap_players
  end

  # TODO
  def game_over?
    false
  end

  def draw_console
    # TODO: Add move history, taken pieces, menu etc
    board.render_board
  end

  private

  def post_move_update(piece_pos)
    piece = board.grid[piece_pos.first][piece_pos.last]
    piece.update
  end

  def swap_players
    @players.rotate!
  end

  # OPTIMIZE: shit name
  def check_move
    move = players.first.input_move
    SaveManager.save_game(self) if move == "save"
    move = Move.new(move) # Should this be a class or instance level method?
    return move if ref.valid_move?(move, board.grid, players.first)

    check_move
  end

  def clear_console
    puts "\e[H\e[2J"
  end
end
