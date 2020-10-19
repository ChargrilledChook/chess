require_relative "../lib/board"

describe Board do
  subject(:board) { described_class.new(input, empty_cell) }
  let(:empty_cell) { 0 }
  let(:input) { { [0, 0] => 8, [4, 5] => 7 } }

  describe "#place_move" do
    context "with valid input" do
      it "correctly moves rank" do
        start = [0, 0]
        fin = [1, 0]
        board.place_move(start, fin)

        expect(board.grid[0][0]).to eql(empty_cell)
        expect(board.grid[1][0]).to eql(8)
      end
      it "correctly moves file" do
        start = [0, 0]
        fin = [0, 1]
        board.place_move(start, fin)

        expect(board.grid[0][0]).to eql(empty_cell)
        expect(board.grid[0][1]).to eql(8)
      end
      it "correctly captures" do
        start = [0, 0]
        fin = [4, 5]
        board.place_move(start, fin)

        expect(board.grid[0][0]).to eql(empty_cell)
        expect(board.grid[4][5]).to eql(8)
      end
      it "correctly 'moves' an empty square" do
        start = [1, 1]
        fin = [2, 2]
        board.place_move(start, fin)

        expect(board.grid[2][2]).to eq(0)
      end
    end

    # TODO: Error handling currently not implemented. Being handled by another class.
    context "with invalid input" do
      it "does not move anything" do
        # TODO
      end
    end
  end

  describe "#empty_grid" do
    it "is correct after running" do
      before =    [[8, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 7, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0]]
      after =     [[0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0]]

      expect { board.empty_grid }.to change { board.grid }.from(before).to(after)
    end
  end

  describe "#place_pieces" do
    subject(:board) { described_class.new({}, empty_cell) }

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
      it "works with a larger hash" do
        input = { [1, 1] => 5, [7, 7] => 6, [4, 5] => 7, [7, 0] => 8 }
        result = board.grid
        expected = [[0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 5, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 7, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0, 0, 0, 0],
                    [8, 0, 0, 0, 0, 0, 0, 6]]
        board.place_pieces(input)

        expect(result).to eql expected
      end
      it "works with different data types" do
        input = { [0, 0] => 1, [0, 1] => "2", [0, 2] => :three, [0, 3] => [4, 4] }
        result = board.grid
        expected = [[1, "2", :three, [4, 4], 0, 0, 0, 0],
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

    # TODO: See #place_move re error handling
    context "with invalid input" do
    end
  end

  # TODO: Probably not testable in current state. Not sure if it needs
  # to be tested at all; it should be immediately obvious when playing
  # if it's wrong.
  describe "#render_board" do
    context "when empty" do
    end
  end
end
