#require "pry"

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
    # 2 AI :
    # players: [ComputerPlayer.new(colour: :white, board: board, move_tree: move_tree), ComputerPlayer.new(colour: :black, board: board, move_tree: move_tree)]
    # 1 Each:
    # players: [Player.new(colour: :white), ComputerPlayer.new(colour: :black, board: board, move_tree: move_tree)]
    # 2 human:
    # players: [Player.new(colour: :white), Player.new(colour: :black)]
  )

    @board = board
    @ref = ref
    @move_tree = move_tree
    post_initialize(player_types)
  end

  def post_initialize(player_types)
    case player_types
    when "1"
      @players = two_humans
    when "2"
      @players = one_human_one_ai
    when "3"
      @players = two_ai
    else
      puts "Something went wrong when initialising players. Please try again."
      exit
    end
  end

  def play
    move = players.first.input_move
    round_type(move)
  end

  def normal_round(move)
    return end_round_no_swap unless ref.valid_move?(move, players.first)

    if attempt_move(move)
      redo_round(move.first, move.last)
    else
      update_board(move.first, move.last)
      sleep 0.5
      end_round
    end
  end

  def round_type(move)
    case move
    when "save"
      SaveManager.save_game(self)
    when "exit"
      exit
    when "castle"
      castle_round
    else
      normal_round(move)
    end
  end

  # TODO: Fix this name
  def attempt_move(move)
    ref.save_board_state(move.first, move.last)
    #update_board(move.first, move.last)
    board.place_move(move.first, move.last)
    check = ref.check?(players.first)
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
    @board.grid[starting.first][starting.last].undo_update
  end

  def game_over?
    #binding.pry
    checkmate? || stalemate?
  end

  def checkmate?
    return false unless ref.check?(players.first)

    iterate_over_moves(players.first.colour)
  end

  def stalemate?
    return false if ref.check?(players.first)

    iterate_over_moves(players.first.colour)
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
    colour = players.first.colour
    board.grid[piece_pos.first][piece_pos.last] = select_promotion(colour)
  end

  def swap_players
    @players.rotate!
  end

  def select_promotion(colour)
    print "Select your shiny new piece [Q/K/R/B] :  "
    #choice = gets.chomp.downcase
    choice = "q" # DEBUGGING ONLY
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

  def two_humans
    [Player.new(colour: :white), Player.new(colour: :black)]
  end

  def two_ai
    [ComputerPlayer.new(colour: :white, board: board, move_tree: move_tree), ComputerPlayer.new(colour: :black, board: board, move_tree: move_tree)]
  end

  def one_human_one_ai
    [Player.new(colour: :white), ComputerPlayer.new(colour: :black, board: board, move_tree: move_tree)]
  end
end
