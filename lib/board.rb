# Holds piece objects
class Board
  include PieceIcons # Currently for testing

  attr_accessor :grid # Change to reader

  def initialize
    @grid = Array.new(8) { Array.new(8, "   ") }
  end

  def to_s
    (1..8).each { |num| print " #{num} " }
    print "\n"
    grid.each do |line|
      line.each { |cell| print cell.bg_cyan }
      print "\n"
    end
  end

  def render_proto
    print " #{white_pawn} ".bg_blue + " #{white_pawn} ".bg_black + " #{black_pawn} ".bg_blue + " #{black_pawn} ".bg_black
  end
end
