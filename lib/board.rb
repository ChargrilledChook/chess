# Holds piece objects
class Board
  include PieceIcons # Currently for testing. Move to actual pieces

  EMPTY_CELL = "   ".freeze

  attr_accessor :grid # Change to reader - currently for testing.

  def initialize
    @grid = Array.new(8) { Array.new(8, EMPTY_CELL) }
  end

  def place_move(coords)

  end

  def render_board
    puts %(    A  B  C  D  E  F  G  H).green
    draw_grid
    puts %(    A  B  C  D  E  F  G  H).green
  end

  private

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
