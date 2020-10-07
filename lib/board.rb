# Holds piece objects
class Board
  attr_reader :grid, :empty_cell

  def initialize(pieces_hash)
    @empty_cell = "   ".freeze
    @grid = Array.new(8) { Array.new(8, empty_cell) }
    place_pieces(pieces_hash)
  end

  def place_move(co_ords)
    starting = co_ords.starting
    ending = co_ords.ending
    @grid[ending.first][ending.last] = @grid[starting.first][starting.last]
    @grid[starting.first][starting.last] = empty_cell
  end

  def place_pieces(hash)
    hash.each { |pos, piece| @grid[pos.first][pos.last] = piece }
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
        if black_cell
          print cell.to_s.bg_black
        else
          print cell.to_s.bg_blue
        end
        black_cell = !black_cell
      end
      print " #{counter} ".green
      counter -= 1
      black_cell = !black_cell
      print "\n"
    end
  end
end
