require_relative "../lib/board"

describe Board do
  subject(:board) { described_class.new({}, 0) }

  describe "#place_move" do
    context "with valid input" do
      it "correctly updates the grid" do
        start = [0, 0]
        fin = [1, 1]
        pos = board.grid[1][1]
        board.place_move(start, fin)
        expect(pos).to eq(0)
      end
    end
  end

  describe "#place_pieces" do
  end

  describe "#render_board" do
  end
end
