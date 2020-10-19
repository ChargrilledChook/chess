class Pawn < Piece
  attr_reader :first_move

  def post_initialize
    @first_move = true
  end

  def move_list(board, starting)
    move_map(board, starting) + attack_map(board, starting)
  end

  def update
    toggle_first_move
  end

  def toggle_first_move
    @first_move = false
  end

  def to_s
    colour == :white ? white_pawn : black_pawn
  end

  def promotable?(pos)
    case colour
    when :white
      pos.first == 0
    when :black
      pos.first == 7
    end
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

  def move_map(board, starting)
    single = single_map(board, starting)
    return single if single.empty? || !first_move

    single + double_map(board, starting)
  end

  def attack_map(board, move)
    list = attacks.map { |atk| [move.first + atk.first, move.last + atk.last] }
    list.select { |atk| valid_move?(board, atk) && enemy?(board, atk) }
  end

  def single_map(board, starting)
    single = single_move.map { |move| [starting.first + move.first, starting.last + move.last] }
    single.select { |move| valid_move?(board, move) && empty?(board, move) }
  end

  def double_map(board, starting)
    double = double_move.map { |move| [starting.first + move.first, starting.last + move.last] }
    double.select { |move| valid_move?(board, move) && empty?(board, move) }
  end
end
