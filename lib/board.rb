# Main responsibility is to hold piece objects / represent the gameboard.
# Implemented with a 2D array. Empty squares / cells are filled with an EmptySquare
# object, so they can respond to queries from other objects.
# In hindsight a more robust system of nodes may have lead to a better design - for instance,
# every index being a square object that could hold pieces as a value.
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
    puts letter_coords + draw_grid + letter_coords
  end

  private

  def letter_coords
    %(    A  B  C  D  E  F  G  H\n).green
  end

  def map_bg_colours
    @grid.each_with_index.map do |line, idx|
      black_cell = idx.even? ? true : false
      line.map do |cell|
        res = black_cell ? cell.to_s.bg_blue : cell.to_s.bg_black
        black_cell = black_cell ? false : true
        res
      end
    end
  end

  def draw_grid
    counter = 8
    final = map_bg_colours.map do |line|
      res = " #{counter} ".green + line.join + " #{counter} ".green + "\n"
      counter -= 1
      res
    end
    final.join
  end
end
