# require "pry"

# Co-ordinates collaborating objects to play a single round of chess
class Round
  include Display
  include Castle
  include SaveManager
  include PieceCollections

  attr_reader :players, :board, :ref

  def initialize(
    board: Board.new(default_pieces),
    ref: Referee.new(board),
    player_types:
  )

    @board = board
    @ref = ref
    post_initialize(player_types)
  end

  def post_initialize(player_types)
    case player_types
    when "1" then @players = two_humans
    when "2" then @players = one_human_one_ai
    when "3" then @players = one_ai_one_human
    when "4" then @players = two_ai
    else
      puts player_selection_error_msg
      exit
    end
  end

  def play
    move = current_player.input_move
    round_type(move)
  end

  def round_type(move)
    case move
    when "save" then SaveManager.save_game(self)
    when "exit" then exit
    when "castle" then castle_round
    when "help" then puts help_msg
    else normal_round(move)
    end
  end

  def normal_round(move)
    return end_round_no_swap unless ref.valid_move?(move, current_player)

    # TODO: Rename
    if ref.attempt_move(move, current_player)
      ref.restore_board(move.first, move.last)
    else
      update_board(move.first, move.last)
      sleep 0.1 if current_player.ai
      end_round
    end
  end

  def boot_game
    clear_console
    draw_console
  end

  def checkmate?
    ref.checkmate?(current_player)
  end

  def stalemate?
    ref.stalemate?(players)
  end

  private

  def draw_console
    board.render_board
    check_message
  end

  def clear_console
    Display.clear_console
  end

  # TODO: Extract to display
  def check_message
    ref.check?(players.last) ? puts("\n#{players.last.colour.capitalize} is in check!") : puts("\n\n")
  end

  def update_board(from, to)
    board.place_move(from, to)
    post_move_update(to)
  end

  def post_move_update(piece_pos)
    piece = board.grid[piece_pos.first][piece_pos.last]
    piece.update(piece_pos)
    promote(piece_pos) if piece.promotable?(piece_pos)
  end

  def promote(piece_pos)
    colour = current_player.colour
    board.grid[piece_pos.first][piece_pos.last] = select_promotion(colour)
  end

  def swap_players
    @players.rotate!
  end

  def select_promotion(colour)
    choice = current_player.choose_promotion
    case choice
    when "q" then Queen.new(colour: colour)
    when "k" then Knight.new(colour: colour)
    when "r" then Rook.new(colour: colour)
    when "b" then Bishop.new(colour: colour)
    else select_promotion(colour)
    end
  end

  def end_round
    clear_console
    draw_console
    swap_players
  end

  def end_round_no_swap
    clear_console
    draw_console
  end

  def current_player
    players.first
  end

  def two_humans
    [Player.new(colour: :white), Player.new(colour: :black)]
  end

  def two_ai
    [ComputerPlayer.new(colour: :white, board: board),
     ComputerPlayer.new(colour: :black, board: board)]
  end

  def one_human_one_ai
    [Player.new(colour: :white), ComputerPlayer.new(colour: :black, board: board)]
  end

  def one_ai_one_human
    [ComputerPlayer.new(colour: :white, board: board), Player.new(colour: :black)]
  end
end
