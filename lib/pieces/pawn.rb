class Pawn < Piece
  attr_reader :first_move

  def post_initialize(first_move: true)
    @first_move = first_move
  end

  # BUG: Unsuccessful move eats first move bonus
  # BUG: Double move can jump
  # HACK: This code sucks refactor it
  def move_list(board, starting)
    res = []
    moves.each do |move|
      begin
        space = board[starting.first + move.first][starting.last + move.last]
        if space.colour == :none
          res << [starting.first + move.first, starting.last + move.last]
        end
      rescue NoMethodError
        next
      end
    end

    attacks.each do |atk|
      begin
        space = board[starting.first + atk.first][starting.last + atk.last]
        next if space.colour == :none

        if space.colour == enemy_colour
          res << [starting.first + atk.first, starting.last + atk.last]
        end
      rescue NoMethodError
        next
      end
    end
    @first_move = false
    res
  end

  def moves
    if first_move
      colour == :white ? [[-2, 0], [-1, 0]] : [[2, 0], [1, 0]]
    else
      colour == :white ? [[-1, 0]] : [[1, 0]]
    end
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end

  def attacks
    case colour
    when :white
      [[-1, -1], [-1, 1]]
    when :black
      [[1, -1], [1, 1]]
    end
  end
end
