require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/rook"

describe Rook do
  subject(:rook) { described_class.new(colour: :white) }
  let(:empty)    { double("empty", colour: :none) }

  describe "#move_list" do
    context "on an empty board" do
      let(:board)  { Array.new(8) { Array.new(8, empty) } }

      it "is correct in the centre" do
        board[4][5] = rook
        rook_moves = rook.move_list(board, [4, 5])
        expected = [3, 5], [2, 5], [1, 5], [0, 5], [5, 5], [6, 5], [7, 5],
                   [4, 4], [4, 3], [4, 2], [4, 1], [4, 0], [4, 6], [4, 7]

        expect(rook_moves).to match_array(expected)
      end
      it "is correct in the corners" do
        board[0][7] = rook
        rook_moves = rook.move_list(board, [0, 7])
        expected = [0, 0], [0, 1], [0, 2], [0, 3], [0, 4], [0, 5], [0, 6],
                   [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7], [7, 7]

        expect(rook_moves).to match_array(expected)
      end
      it "is correct in another corner" do
        board[7][7] = rook
        rook_moves = rook.move_list(board, [7, 7])
        expected = [7, 0], [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6],
                   [0, 7], [1, 7], [2, 7], [3, 7], [4, 7], [5, 7], [6, 7]

        expect(rook_moves).to match_array(expected)
      end
      it "is correct in another corner" do
        board[7][0] = rook
        rook_moves = rook.move_list(board, [7, 0])
        expected = [7, 1], [7, 2], [7, 3], [7, 4], [7, 5], [7, 6], [7, 7],
                   [0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]

        expect(rook_moves).to match_array(expected)
      end
    end

    context "with friendly pieces" do
      let(:mini_board) { Array.new(4) { Array.new(4, empty) } }
      let(:friend) { double("friend", colour: :white) }

      it "is correct at a distance" do
        mini_board[0][0] = rook
        mini_board[0][2] = friend
        rook_moves = rook.move_list(mini_board, [0, 0])
        expected = [0, 1], [1, 0], [2, 0], [3, 0]

        expect(rook_moves).to match_array(expected)
      end
      it "is correct on the horiztonal" do
        mini_board[0][3] = rook
        mini_board[1][3] = friend
        rook_moves = rook.move_list(mini_board, [0, 3])
        expected = [0, 0], [0, 1], [0, 2]

        expect(rook_moves).to match_array(expected)
      end
      it "is correct when blocked" do
        mini_board[3][3] = rook
        mini_board[2][3] = friend
        mini_board[3][2] = friend
        rook_moves = rook.move_list(mini_board, [3, 3])
        expected = []

        expect(rook_moves).to match_array(expected)
      end
    end
    context "with enemy pieces" do
      let(:mini_board) { Array.new(4) { Array.new(4, empty) } }
      let(:enemy) { double("enemy", colour: :black) }

      it "works on a vertical" do
        mini_board[1][1] = rook
        mini_board[3][1] = enemy
        rook_moves = rook.move_list(mini_board, [1, 1])
        expected = [3, 1]

        expect(rook_moves).to include(expected)
      end
      it "works on a horizontal" do
        mini_board[0][3] = rook
        mini_board[0][0] = enemy
        rook_moves = rook.move_list(mini_board, [0, 3])
        expected = [0, 0]

        expect(rook_moves).to include(expected)
      end
      it "works when adjacaent" do
        mini_board[3][3] = rook
        mini_board[3][2] = enemy
        mini_board[2][3] = enemy
        rook_moves = rook.move_list(mini_board, [3, 3])
        expected = [3, 2], [2, 3]

        expect(rook_moves).to match_array(expected)
      end
    end

    context "with enemies and friends" do
      subject(:rook) { described_class.new(colour: :black) }
      let(:board)    { Array.new(8) { Array.new(8, empty) } }
      let(:enemy)    { double("enemy", colour: :white) }
      let(:friend)   { double("friend", colour: :black) }

      it "works correctly" do
        board[2][2] = rook
        board[2][1] = friend
        board[0][2] = friend
        board[3][2] = enemy
        board[2][5] = enemy
        rook_moves = rook.move_list(board, [2, 2])
        expected = [1, 2], [3, 2], [2, 3], [2, 4], [2, 5]

        expect(rook_moves).to match_array(expected)
      end

      it "is correct when an enemy is wrapped " do
        board[0][0] = rook
        board[0][1] = friend
        board[1][0] = friend
        board[7][0] = enemy
        rook_moves = rook.move_list(board, [0, 0])
        expected = []

        expect(rook_moves).to match_array(expected)
      end
    end
  end

  describe "#to_s" do
    context "when rook is white" do
      subject(:white_rook) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_rook.to_s).to match "\u2656"
      end
    end

    context "when rook is black" do
      subject(:black_rook) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_rook.to_s).to match "\u265C"
      end
    end
  end
end
