# Co-ordinates collaborating objects to play a single round of chess
class Round
  include SaveManager
  include PieceCollections

  attr_reader :players, :board, :ref, :move_tree

  def initialize(
    players: [Player.new(colour: :white), Player.new(colour: :black)],
    board: Board.new(default_pieces),
    ref: Referee.new(board),
    move_tree: MoveTree.new(board)
  )

    @players = players
    @board = board
    @ref = ref
    @move_tree = move_tree
  end

  def play
    move = check_move
    update_board(move.first, move.last)
    if ref.check?(players.first)
      redo_round(move.first, move.last)
      play
    else
      end_round
    end
  end

  # TODO: Fix this name
  def fake_play(move)
    ref.save_board_state(move.first, move.last)
    update_board(move.first, move.last)
    check = ref.check?(players.first)
    redo_round(move.first, move.last)
    check
  end

  # TODO: Fix this name
  def iterate_over_moves(colour)
    moves = move_tree.convert_to_moves(colour)
    moves.all? do |from, to|
      fake_play([from, to])
    end
  end

  def redo_round(starting, ending)
    ref.restore_board(starting, ending)
    @board.grid[starting.first][starting.last].undo_update
  end

  def game_over?
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

  # OPTIMIZE: shit name
  def check_move
    move = players.first.input_move
    SaveManager.save_game(self) if move == "save"
    move = Move.new(move) # TODO: Move this part of the logic to player
    return move.data if ref.valid_move?(move.data, players.first)

    check_move
  end

  def select_promotion(colour)
    print "Select your shiny new piece [Q/K/R/B] :  "
    choice = gets.chomp.downcase
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

  def clear_console
    puts "\e[H\e[2J"
  end
end
