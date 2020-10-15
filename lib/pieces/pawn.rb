class Pawn < Piece
  attr_reader :first_move

  def post_initialize
    @first_move = true
  end

  # BUG: Unsuccessful move eats first move bonus
  # BUG: Double move can jump
  def move_list(board, starting)
    move_map(board, starting) + attack_map(board, starting)
  end

  def toggle_first_move
    @first_move = false
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end

  private

  def single_move
    colour == :white ? [[-1, 0]] : [[1, 0]]
  end

  def double_move
    colour == :white ? [[-2, 0]] : [[2, 0]]
  end

  def attacks
    case colour
    when :white
      [[-1, -1], [-1, 1]]
    when :black
      [[1, -1], [1, 1]]
    end
  end

  # OPTIMIZE: Extract logic into helper methods
  def move_map(board, starting)
    single = single_move.map { |move| [starting.first + move.first, starting.last + move.last] }
    single.select! { |move| valid_move?(board, move) && empty?(board, move) }
    return single if single.empty? || !first_move

    double = double_move.map { |move| [starting.first + move.first, starting.last + move.last] }
    single + double.select { |move| valid_move?(board, move) && empty?(board, move) }
  end

  def attack_map(board, move)
    list = attacks.map { |atk| [move.first + atk.first, move.last + atk.last] }
    list.select { |atk| valid_move?(board, atk) && enemy?(board, atk) }
  end
end
