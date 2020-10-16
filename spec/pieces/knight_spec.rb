require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/knight"

describe Knight do
  subject(:knight) { described_class.new(colour: :white) }
  let(:empty)      { double("empty", colour: :none) }
  let(:board)      { Array.new(5) { Array.new(5, empty) } }

  describe "#move_list" do
    context "on an empty board" do
      it "works in the centre" do
        board[2][2] = Knight
        knight_moves = knight.move_list(board, [2, 2])
        expected = [0, 1], [0, 3], [1, 4], [3, 4],
                   [4, 3], [4, 1], [3, 0], [1, 0]

        expect(knight_moves).to match_array(expected)
      end
      it "works on the side" do
        board[2][0] = knight
        knight_moves = knight.move_list(board, [2, 0])
        expected = [0, 1], [1, 2], [3, 2], [4, 1]

        expect(knight_moves).to match_array(expected)
      end
      it "works on a corner" do
        board[0][0] = knight
        knight_moves = knight.move_list(board, [0, 0])
        expected = [1, 2], [2, 1]

        expect(knight_moves).to match_array(expected)
      end
      it "works on another corner" do
        board[4][4] = knight
        knight_moves = knight.move_list(board, [4, 4])
        expected = [2, 3], [3, 2]

        expect(knight_moves).to match_array(expected)
      end
    end

    context "with friendly pieces" do
      let(:friend) { double("friend", colour: :white) }

      it "works correctly" do
        board[2][2] = Knight
        board[0][1] = friend
        board[3][4] = friend
        board[1][4] = friend
        knight_moves = knight.move_list(board, [2, 2])
        expected = [0, 3], [4, 3], [4, 1], [3, 0], [1, 0]

        expect(knight_moves).to match_array(expected)
      end
    end

    context "with enemy pieces" do
      let(:enemy) { double("enemy", colour: :black) }

      it "works correctly" do
        board[2][2] = Knight
        board[0][1] = enemy
        board[3][4] = enemy
        board[1][4] = enemy
        knight_moves = knight.move_list(board, [2, 2])
        expected = [0, 1], [0, 3], [1, 4], [3, 4],
                   [4, 3], [4, 1], [3, 0], [1, 0]

        expect(knight_moves).to match_array(expected)
      end
    end

    context "with enemies and friends" do
      subject(:knight) { described_class.new(colour: :black) }
      let(:enemy)      { double("enemy", colour: :white) }
      let(:friend)     { double("friend", colour: :black) }

      it "works correctly" do
        board[2][2] = Knight
        board[4][1] = enemy
        board[1][0] = enemy
        board[1][3] = enemy
        board[0][3] = friend
        board[1][4] = friend
        board[3][0] = friend
        knight_moves = knight.move_list(board, [2, 2])
        expected = [0, 1], [3, 4], [4, 3], [4, 1], [1, 0]

        expect(knight_moves).to match_array(expected)
      end
    end
  end

  describe "#to_s" do
    context "when knight is white" do
      subject(:white_knight) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_knight.to_s).to match  "\u2658"
      end
    end

    context "when knight is black" do
      subject(:black_knight) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_knight.to_s).to match  "\u265E"
      end
    end
  end
end
