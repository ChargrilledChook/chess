# Co-ordinates collaborating objects to play a single round of chess. Contains all data about
# game state, so can be serialised to save a game - including the board, object positions, their state,
# player type and turn order. It will only update the board / turn order after a legal, successful move. It leans
# on the referee class to help it implement the rules.
#
# This class as a whole is in need of refactoring. It has taken on too many responsibilites and needs to broken
# down into smaller pieces, or implement a different approach. While it was originally lean and focused it gathered
# a lot of cruft and bloat as various little special rules, exceptions and caveats were added. Promotion, castling,
# and en passant logic could probably be delegated to new objects.
class Round
  include Display
  include CastleRound
  include SaveManager
  include PieceCollections
  include PlayerTypes

  attr_reader :players, :board, :ref, :pass_array

  def initialize(
    board: Board.new(default_pieces),
    ref: Referee.new(board),
    player_types:
  )

    @board = board
    @ref = ref
    @pass_array = []

    post_initialize(player_types)
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

  # HACK
  def post_move_update(piece_pos)
    piece = board.grid[piece_pos.first][piece_pos.last]
    passing_test(piece, piece_pos)
    pass_array.first.first.update unless pass_array.empty?
    pass_array.clear
    piece.update(piece_pos)
    pass_array << [piece, piece_pos] if piece.passable
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

  def passing_test(piece, pos)
    square = piece.colour == :white ? 1 : -1
    passee = board.grid[pos.first + square][pos.last]
    board.grid[pos.first + square][pos.last] = EmptySquare.new if piece.passer? && passee.passable
    legal_pass
  rescue NoMethodError
    nil
  end

  def legal_pass
    raise StandardError.new(en_passant_error) if ref.check?(current_player)
  end
end
