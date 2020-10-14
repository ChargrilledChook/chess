require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/queen"

describe Queen do
  subject(:queen) { described_class.new(colour: :white) }
  let(:empty)     { double("empty", colour: :none) }
  let(:board)     { Array.new(5) { Array.new(5, empty) } }

  describe "#move_list" do
    context "on an empty board" do
      it "is correct in the centre" do
        board[2][2] = queen
        queen_moves = queen.move_list(board, [2, 2])
        expected = [0, 0], [1, 1], [3, 3], [4, 4],
                   [4, 0], [3, 1], [1, 3], [0, 4],
                   [2, 0], [2, 1], [2, 3], [2, 4],
                   [0, 2], [1, 2], [3, 2], [4, 2]
        expect(queen_moves).to match_array(expected)
      end
      it "is correct on a side" do
        board[3][4] = queen
        queen_moves = queen.move_list(board, [3, 4])
        expected = [3, 0], [3, 1], [3, 2], [3, 3],
                   [4, 3], [4, 4], [2, 4], [1, 4],
                   [0, 4], [2, 3], [1, 2], [0, 1]

        expect(queen_moves).to match_array(expected)
      end
      it "is correct from a corner" do
        board[4][0] = queen
        queen_moves = queen.move_list(board, [4, 0])
        expected = [0, 0], [1, 0], [2, 0], [3, 0],
                   [4, 1], [4, 2], [4, 3], [4, 4],
                   [3, 1], [2, 2], [1, 3], [0, 4]

        expect(queen_moves).to match_array(expected)
      end
    end

    context "with friendly pieces" do

    end

    context "with enemy pieces" do

    end

    context "with enemies and friends" do

    end
  end

  describe "#to_s" do
    context "when queen is white" do
      subject(:white_queen) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_queen.to_s).to match "\u2655"
      end
    end

    context "when queen is black" do
      subject(:black_queen) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_queen.to_s).to match "\u265B"
      end
    end
  end
end
