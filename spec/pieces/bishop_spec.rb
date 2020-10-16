require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/bishop"

describe Bishop do
  subject(:bishop) { described_class.new(colour: :white) }
  let(:empty)      { double("empty", colour: :none) }
  let(:board)      { Array.new(5) { Array.new(5, empty) } }

  describe "#move_list" do
    context "on an empty board" do
      it "is correct in the centre" do
        board[2][2] = bishop
        bishop_moves = bishop.move_list(board, [2, 2])
        expected = [0, 0], [1, 1], [3, 3], [4, 4],
                   [4, 0], [3, 1], [1, 3], [0, 4]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct from a left corner" do
        board[4][0] = bishop
        bishop_moves = bishop.move_list(board, [4, 0])
        expected = [3, 1], [2, 2], [1, 3], [0, 4]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct from a right corner" do
        board[4][4] = bishop
        bishop_moves = bishop.move_list(board, [4, 4])
        expected = [3, 3], [2, 2], [1, 1], [0, 0]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct from a top corner" do
        board[0][0] = bishop
        bishop_moves = bishop.move_list(board, [0, 0])
        expected = [3, 3], [2, 2], [1, 1], [4, 4]

        expect(bishop_moves).to match_array(expected)
      end
    end

    context "with friendly pieces" do
      let(:friend) { double("friend", colour: :white) }

      it "is correct at a distance" do
        board[2][2] = bishop
        board[0][0] = friend
        board[4][0] = friend
        bishop_moves = bishop.move_list(board, [2, 2])
        expected = [1, 1], [3, 3], [4, 4],
                   [3, 1], [1, 3], [0, 4]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct when adjacaent" do
        board[2][2] = bishop
        board[1][1] = friend
        board[3][1] = friend
        bishop_moves = bishop.move_list(board, [2, 2])
        expected = [1, 3], [0, 4], [3, 3], [4, 4]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct when blocked" do
        board[4][4] = bishop
        board[3][3] = friend
        bishop_moves = bishop.move_list(board, [4, 4])
        expected = []

        expect(bishop_moves).to match_array(expected)
      end
    end

    context "with enemy pieces" do
      let(:enemy) { double("friend", colour: :black) }

      it "is correct at a distance" do
        board[2][2] = bishop
        board[0][0] = enemy
        board[4][0] = enemy
        bishop_moves = bishop.move_list(board, [2, 2])
        expected = [0, 0], [1, 1], [3, 3], [4, 4],
                   [4, 0], [3, 1], [1, 3], [0, 4]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct when adjacaent" do
        board[2][2] = bishop
        board[1][1] = enemy
        board[3][1] = enemy
        bishop_moves = bishop.move_list(board, [2, 2])
        expected = [1, 3], [0, 4], [3, 3], [4, 4], [1, 1], [3, 1]

        expect(bishop_moves).to match_array(expected)
      end
      it "is correct when blocked" do
        board[4][4] = bishop
        board[3][3] = enemy
        bishop_moves = bishop.move_list(board, [4, 4])
        expected = [[3, 3]]

        expect(bishop_moves).to match_array(expected)
      end
    end

    context "with enemies and friends" do
      subject(:bishop) { described_class.new(colour: :black) }
      let(:enemy)      { double("enemy", colour: :white) }
      let(:friend)     { double("friend", colour: :black) }

      it "works correctly" do
        board[3][1] = bishop
        board[4][0] = friend
        board[1][3] = friend
        board[0][4] = enemy
        board[2][0] = enemy
        bishop_moves = bishop.move_list(board, [3, 1])
        expected = [2, 0], [4, 2], [2, 2]

        expect(bishop_moves).to match_array(expected)
      end
    end
  end

  describe "#to_s" do
    context "when bishop is white" do
      subject(:white_bishop) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_bishop.to_s).to match  "\u2657"
      end
    end

    context "when bishop is black" do
      subject(:black_bishop) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_bishop.to_s).to match  "\u265D"
      end
    end
  end
end
