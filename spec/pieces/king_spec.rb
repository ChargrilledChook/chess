require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/king"

describe King do
  subject(:king) { described_class.new(colour: :white) }
  let(:empty)    { double("empty", colour: :none) }
  let(:board)    { Array.new(5) { Array.new(5, empty) } }

  describe "#move_list" do
    context "on an empty board" do
      it "works in the centre" do
        board[2][2] = king
        king_moves = king.move_list(board, [2, 2])
        expected = [1, 1], [1, 2], [1, 3], [2, 1],
                   [2, 3], [3, 1], [3, 2], [3, 3]

        expect(king_moves).to match_array(expected)
      end
      xit "works in a corner" do
        board[4][0] = king
        king_moves = king.move_list(board, [4, 0])
        expected = [3, 0], [3, 1], [4, 1]

        expect(king_moves).to match_array(expected)
      end
      xit "works in another corner" do
        board[0][4] = king
        king_moves = king.move_list(board, [0, 4])
        expected = [0, 3], [1, 3], [1, 4]

        expect(king_moves).to match_array(expected)
      end
    end

    context "with friendly pieces" do
      let(:friend) { double("friend", colour: :white) }

      it "works when partially blocked" do
        board[2][1] = king
        board[3][0] = friend
        board[1][1] = friend
        board[2][2] = friend
        king_moves = king.move_list(board, [2, 1])
        expected = [1, 0], [2, 0], [3, 1], [1, 2], [3, 2]

        expect(king_moves).to match_array(expected)
      end
      it "works when completely blocked" do
        board[2][1] = king
        board[3][0] = friend
        board[1][1] = friend
        board[2][2] = friend
        board[1][0] = friend
        board[2][0] = friend
        board[3][1] = friend
        board[1][2] = friend
        board[3][2] = friend
        king_moves = king.move_list(board, [2, 1])
        expected = []

        expect(king_moves).to match_array(expected)
      end
    end

    context "with enemy pieces" do
      let(:enemy) { double("enemy", colour: :black) }

      it "works correctly" do
        board[2][2] = king
        board[3][1] = enemy
        board[1][2] = enemy
        king_moves = king.move_list(board, [2, 2])
        expected = [1, 1], [1, 2], [1, 3], [2, 1],
                   [2, 3], [3, 1], [3, 2], [3, 3]

        expect(king_moves).to match_array(expected)
      end
    end

    context "with enemies and friends" do
      subject(:king) { described_class.new(colour: :black) }
      let(:enemy)    { double("enemy", colour: :white) }
      let(:friend)   { double("friend", colour: :black) }

      it "works correctly" do
        board[2][2] = king
        board[1][1] = enemy
        board[3][2] = enemy
        board[2][1] = friend
        board[3][3] = friend
        king_moves = king.move_list(board, [2, 2])
        expected = [1, 1], [1, 2], [1, 3],
                   [2, 3], [3, 1], [3, 2]

        expect(king_moves).to match_array(expected)
      end
    end
  end

  describe "#to_s" do
    context "when king is white" do
      subject(:white_king) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_king.to_s).to match  "\u2654"
      end
    end

    context "when king is black" do
      subject(:black_king) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_king.to_s).to match  "\u265A"
      end
    end
  end
end
