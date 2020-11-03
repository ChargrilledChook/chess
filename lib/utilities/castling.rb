# Helper module for round object, to create a special type of round. This is because castling is unique
# in that a player moves multiple pieces in a single turn.
#
# This implementation overcomplicated the problem and overengineered the solution -
# it simulates every move the king makes to make sure
# he doesn't move into or through check, but this could have
# been achieved by simpling seeing if the three relevant squares
# are under attack. Prime candidate for easy refactoring
module CastleRound
  def pick_castle_type
    print "Castle left or right? [L/r]: "
    choice = gets.chomp.downcase
    case current_player.colour
    when :white
      choice == "r" ? white_short : white_long
    when :black
      choice == "r" ? black_short : black_long
    else
      puts "Something went wrong"
    end
  end

  def castle_round
    moves = pick_castle_type
    return false unless can_castle?(moves)

    if castle_moves(moves.moves)
      successful_castle(moves)
    else
      backup(moves.backup)
    end
  end

  def castle_moves(moves)
    moves.none? do |move|
      board.place_move(move.first, move.last)
      ref.check?(current_player)
    end
  end

  def can_castle?(moves)
    king = board.grid[moves.king_starting.first][moves.king_starting.last]
    rook = board.grid[moves.rook_starting.first][moves.rook_starting.last]
    return false unless rook.respond_to?(:first_move) && king.respond_to?(:first_move)
    return false unless rook.first_move && king.first_move
    return false if ref.check?(players.first)
    return false unless squares_empty?(moves.empties)

    true
  end

  def successful_castle(moves)
    king = board.grid[moves.king_ending.first][moves.king_ending.last]
    rook = board.grid[moves.rook_ending.first][moves.rook_ending.last]
    king.update
    rook.update
    end_round
  end

  def squares_empty?(squares)
    squares.all? { |x, y| board.grid[x][y].colour == :none }
  end

  Castle = Struct.new(:king_starting, :king_ending, :rook_starting, :rook_ending, :moves, :empties, :backup)

  def white_short
    Castle.new([7, 4],
               [7, 6],
               [7, 7],
               [7, 5],
               [[[7, 4], [7, 5]], [[7, 5], [7, 6]], [[7, 7], [7, 5]]],
               [[7, 5], [7, 6]],
               :white_short)
  end

  def white_long
    Castle.new([7, 4],
               [7, 2],
               [7, 0],
               [7, 3],
               [[[7, 4], [7, 3]], [[7, 3], [7, 2]], [[7, 0], [7, 3]]],
               [[7, 1], [7, 2], [7, 3]],
               :white_long)
  end

  def black_short
    Castle.new([0, 4],
               [0, 6],
               [0, 7],
               [0, 5],
               [[[0, 4], [0, 5]], [[0, 5], [0, 6]], [[0, 7], [0, 5]]],
               [[0, 5], [0, 6]],
               :black_short)
  end

  def black_long
    Castle.new([0, 4],
               [0, 2],
               [0, 0],
               [0, 3],
               [[[0, 4], [0, 3]], [[0, 3], [0, 2]], [[0, 0], [0, 3]]],
               [[0, 1], [0, 2], [0, 3]],
               :black_long)
  end

  def white_short_backup
    board.grid[7][4] = King.new(colour: :white)
    board.grid[7][5] = EmptySquare.new
    board.grid[7][6] = EmptySquare.new
    board.grid[7][7] = Rook.new(colour: :white)
  end

  def white_long_backup
    board.grid[7][4] = King.new(colour: :white)
    board.grid[7][1] = EmptySquare.new
    board.grid[7][2] = EmptySquare.new
    board.grid[7][3] = EmptySquare.new
    board.grid[7][0] = Rook.new(colour: :white)
  end

  def black_short_backup
    board.grid[0][4] = King.new(colour: :black)
    board.grid[0][5] = EmptySquare.new
    board.grid[0][6] = EmptySquare.new
    board.grid[0][7] = Rook.new(colour: :black)
  end

  def black_long_backup
    board.grid[0][4] = King.new(colour: :black)
    board.grid[0][1] = EmptySquare.new
    board.grid[0][2] = EmptySquare.new
    board.grid[0][3] = EmptySquare.new
    board.grid[0][0] = Rook.new(colour: :black)
  end

  def backup(type)
    case type
    when :white_short then white_short_backup
    when :white_long then white_long_backup
    when :black_short then black_short_backup
    when :black_long then black_long_backup
    end
  end
end
