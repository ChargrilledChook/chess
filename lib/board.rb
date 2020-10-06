# Holds piece objects
class Board
  attr_reader :grid, :empty_cell

  def initialize
    @empty_cell = "   ".freeze
    @grid = Array.new(8) { Array.new(8, empty_cell) }
    #place_default_pieces
    @grid[2][4] = Rook.new(colour: :black)
    @grid[3][4] = Bishop.new(colour: :black)
    @grid[5][4] = Bishop.new(colour: :white)
    @grid[7][4] = Rook.new(colour: :white)
  end

  # def place_move(co_ords)
  #   co_ords = format_input(co_ords)
  #   @grid[co_ords[2]][co_ords[3]] = @grid[co_ords[0]][co_ords[1]]
  #   @grid[co_ords[0]][co_ords[1]] = empty_cell
  # end

  def place_move(co_ords)
    starting = co_ords.starting
    ending = co_ords.ending
    @grid[ending.first][ending.last] = @grid[starting.first][starting.last]
    @grid[starting.first][starting.last] = empty_cell
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

  # Piece placement should possible be extracted to a module but it's fine here for now
  def place_default_pieces
    place_default_pawns
    place_default_black_pieces
    place_default_white_pieces
  end

  def place_default_pawns
    @grid[1].each_index { |cell| @grid[1][cell] = Pawn.new(colour: :black) }
    @grid[6].each_index { |cell| @grid[6][cell] = Pawn.new(colour: :white) }
  end

  def place_default_black_pieces
    @grid[0][0] = Rook.new(colour: :black)
    @grid[0][1] = Bishop.new(colour: :black)
    @grid[0][2] = Knight.new(colour: :black)
    @grid[0][3] = Queen.new(colour: :black)
    @grid[0][4] = King.new(colour: :black)
    @grid[0][5] = Knight.new(colour: :black)
    @grid[0][6] = Bishop.new(colour: :black)
    @grid[0][7] = Rook.new(colour: :black)
  end

  def place_default_white_pieces
    @grid[7][0] = Rook.new(colour: :white)
    @grid[7][1] = Bishop.new(colour: :white)
    @grid[7][2] = Knight.new(colour: :white)
    @grid[7][3] = Queen.new(colour: :white)
    @grid[7][4] = King.new(colour: :white)
    @grid[7][5] = Knight.new(colour: :white)
    @grid[7][6] = Bishop.new(colour: :white)
    @grid[7][7] = Rook.new(colour: :white)
  end
end
