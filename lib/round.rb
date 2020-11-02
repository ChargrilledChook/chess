# require "pry"

# Co-ordinates collaborating objects to play a single round of chess
class Round
  include Display
  include Castle
  include SaveManager
  include PieceCollections

  attr_reader :players, :board, :ref, :move_tree

  def initialize(
    board: Board.new(default_pieces),
    ref: Referee.new(board),
    move_tree: MoveTree.new(board),
    player_types:
  )

    @board = board
    @ref = ref
    @move_tree = move_tree
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

  def normal_round(move)
    return end_round_no_swap unless ref.valid_move?(move, current_player)

    # TODO: Rename
    if attempt_move(move)
      redo_round(move.first, move.last)
    else
      update_board(move.first, move.last)
      sleep 0.5 if current_player.ai
      end_round
    end
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

  # TODO: Fix this name
  def attempt_move(move)
    ref.save_board_state(move.first, move.last)
    # update_board(move.first, move.last)
    board.place_move(move.first, move.last)
    check = ref.check?(current_player)
    redo_round(move.first, move.last)
    check
  end

  # TODO: Fix this name
  def iterate_over_moves(colour)
    moves = move_tree.convert_to_moves(colour)
    moves.all? do |from, to|
      attempt_move([from, to])
    end
  end

  def redo_round(starting, ending)
    ref.restore_board(starting, ending)
    # @board.grid[starting.first][starting.last].undo_update << This is the culprit. Check there are no other bugs caused by taking it out
  end

  def game_over?
    checkmate? || stalemate?
  end

  def checkmate?
    return false unless ref.check?(current_player)

    iterate_over_moves(current_player.colour)
  end

  def stalemate?
    blocked_stalemate || kings_only_stalemate
  end

  # TODO: Add move history, taken pieces, menu etc
  def draw_console
    board.render_board
    check_message
  end

  # TODO: Extract to display
  def check_message
    ref.check?(players.last) ? puts("\n#{players.last.colour.capitalize} is in check!") : puts("\n\n")
  end

  def clear_console
    Display.clear_console
  end

  private

  def blocked_stalemate
    return false if ref.check?(current_player)

    iterate_over_moves(current_player.colour)
  end

  def kings_only_stalemate
    move_tree.select_pieces(current_player.colour).size == 1 && move_tree.select_pieces(players.last.colour).size == 1
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
    [ComputerPlayer.new(colour: :white, board: board, move_tree: move_tree),
     ComputerPlayer.new(colour: :black, board: board, move_tree: move_tree)]
  end

  def one_human_one_ai
    [Player.new(colour: :white), ComputerPlayer.new(colour: :black, board: board, move_tree: move_tree)]
  end

  def one_ai_one_human
    [ComputerPlayer.new(colour: :white, board: board, move_tree: move_tree), Player.new(colour: :black)]
  end
end
