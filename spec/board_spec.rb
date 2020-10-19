require_relative "../lib/board"

describe Board do
  subject(:board) { described_class.new({}, 0) }

  describe "#place_move" do
    context "with valid input" do
      it "correctly updates the grid" do
        start = [0, 0]
        fin = [1, 1]
        end_pos = board.grid[1][1]
        board.place_move(start, fin)
        expect(end_pos).to eq(0)
      end
    end
  end

  describe "#place_pieces" do
    context "with valid input" do
      it "works with an empty hash" do
        input = {}
        board.place_pieces(input)
        result = board.grid.all? { |rank| rank.all?(0) }

        expect(result).to be true
      end
      it "works with a single entry" do
        input = { [0, 0] => 5 }
        result = board.grid
        expected = [[5, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0]]
        board.place_pieces(input)

        expect(result).to eql expected
      end
    end
  end

  describe "#render_board" do
  end
end
