# Holds piece objects
class Board
  attr_accessor :grid # Change to reader

  def initialize
    @grid = Array.new(8) { Array.new(8, 0) }
  end
end
