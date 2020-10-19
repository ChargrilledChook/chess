# Holds piece objects
class Board
  attr_reader :grid

  def initialize(pieces_hash, empty_cell = EmptySquare.new)
    @empty_cell = empty_cell
    @grid = empty_grid
    place_pieces(pieces_hash)
  end

  def place_move(start, fin)
    @grid[fin.first][fin.last] = @grid[start.first][start.last]
    @grid[start.first][start.last] = @empty_cell
  end

  def place_pieces(hash)
    hash.each { |pos, piece| @grid[pos.first][pos.last] = piece }
  end

  def empty_grid
    @grid = Array.new(8) { Array.new(8, @empty_cell) }
  end

  def render_board
    puts %(    A  B  C  D  E  F  G  H).green
    draw_grid
    puts %(    A  B  C  D  E  F  G  H).green
  end

  private

  # HACK: Refactor
  def draw_grid
    black_cell = false
    counter = 8
    @grid.each do |line|
      print " #{counter} ".green
      line.each do |cell|
        print_cell(cell, black_cell)
        black_cell = !black_cell
      end
      print " #{counter} ".green
      counter -= 1
      black_cell = !black_cell
      print "\n"
    end
  end

  def print_cell(cell, black_cell)
    if black_cell
      print cell.to_s.bg_black
    else
      print cell.to_s.bg_blue
    end
  end
end
