# Co-ordinates collaborating objects to play a single round of chess
class Round
  include SaveManager
  include NotationConverter
  include PieceCollections

  attr_reader :players, :board, :ref

  def initialize(
    players: [Player.new(colour: :white), Player.new(colour: :black)],
    board: Board.new(default_pieces),
    ref: Referee.new(board)
  )

    @players = players
    @board = board
    @ref = ref
  end

  def play
    move = check_move
    board.place_move(move.starting, move.ending)
    post_move_update(move.ending)
    redo_round(move.starting, move.ending) if ref.check?(board.grid, players.first)

    end_round
  end

  def redo_round(starting, ending)
    ref.restore_board(starting, ending)
    @board.grid[starting.first][starting.last].undo_update
    play
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
    piece.update(piece_pos)
    promote(piece_pos) if piece.promotable?(piece_pos)
  end

  def promote(piece_pos)
    colour = players.first.colour
    board.grid[piece_pos.first][piece_pos.last] = select_promotion(colour)
  end

  def swap_players
    @players.rotate!
  end

  # OPTIMIZE: shit name
  def check_move
    move = players.first.input_move
    SaveManager.save_game(self) if move == "save"
    move = Move.new(move) # Should this be a class or instance level method?
    return move if ref.valid_move?(move, board.grid)

    check_move
  end

  def select_promotion(colour)
    print "Select your shiny new piece [Q/K/R/B] :  "
    choice = gets.chomp.downcase
    case choice
    when 'q' then Queen.new(colour: colour)
    when 'k' then Knight.new(colour: colour)
    when 'r' then Rook.new(colour: colour)
    when 'b' then Bishop.new(colour: colour)
    else select_promotion(colour)
    end
  end

  def end_round
    clear_console
    draw_console
    swap_players
  end

  def clear_console
    puts "\e[H\e[2J"
  end
end
