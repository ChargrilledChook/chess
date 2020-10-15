require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/pawn"

# TODO:
# * En passant
# * Double move jump bug
# * Unsuccessful double move bug
# * Promotion

describe Pawn do
  let(:empty)    { double("empty", colour: :none) }
  let(:board)    { Array.new(5) { Array.new(5, empty) } }

  describe "#move_list" do
    context "when white" do
      context "when double move is allowed" do
        subject(:pawn) { described_class.new(colour: :white) }

        context "on an empty board" do
          it "works in the cenntre" do
            board[3][2] = pawn
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [2, 2], [1, 2]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the left side" do
            board[4][0] = pawn
            pawn_moves = pawn.move_list(board, [4, 0])
            expected = [3, 0], [2, 0]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the right side" do
            board[3][4] = pawn
            pawn_moves = pawn.move_list(board, [3, 4])
            expected = [2, 4], [1, 4]

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with friendly pieces" do
          let(:friend) { double("friend", colour: :white) }

          it "is correct with one space in front" do
            board[3][2] = pawn
            board[1][2] = friend
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [[2, 2]]

            expect(pawn_moves).to match_array(expected)
          end
          xit "is correct when face to face" do
            board[3][2] = pawn
            board[2][2] = friend
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with enemy pieces" do
          let(:enemy) { double("enemy", colour: :black) }

          it "is correct with one attack" do
            board[3][2] = pawn
            board[2][1] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [2, 2], [1, 2], [2, 1]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct with two attacks" do
            board[3][2] = pawn
            board[2][1] = enemy
            board[2][3] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [2, 2], [1, 2], [2, 1], [2, 3]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct with one space in front" do
            board[3][2] = pawn
            board[1][2] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [[2, 2]]

            expect(pawn_moves).to match_array(expected)
          end
          xit "is correct when face to face" do
            board[3][2] = pawn
            board[2][2] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end
      end

      context "when double move is not allowed" do
        subject(:pawn) { described_class.new(colour: :white) }

        before do
          pawn.toggle_first_move
        end

        context "on an empty board" do
          it "works in the cenntre" do
            board[3][2] = pawn
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [[2, 2]]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the left side" do
            board[4][0] = pawn
            pawn_moves = pawn.move_list(board, [4, 0])
            expected = [[3, 0]]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the right side" do
            board[3][4] = pawn
            pawn_moves = pawn.move_list(board, [3, 4])
            expected = [[2, 4]]

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with friendly pieces" do
          let(:friend) { double("friend", colour: :white) }

          it "is correct when face to face" do
            board[3][2] = pawn
            board[2][2] = friend
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with enemy pieces" do
          let(:enemy) { double("enemy", colour: :black) }

          it "is correct with one attack" do
            board[3][2] = pawn
            board[2][1] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [2, 2], [2, 1]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct with two attacks" do
            board[3][2] = pawn
            board[2][1] = enemy
            board[2][3] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = [2, 2], [2, 1], [2, 3]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct when face to face" do
            board[3][2] = pawn
            board[2][2] = enemy
            pawn_moves = pawn.move_list(board, [3, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end
      end
    end

    context "when black" do
      context "when double move is allowed" do
        subject(:pawn) { described_class.new(colour: :black) }

        context "on an empty board" do
          it "works in the cenntre" do
            board[1][2] = pawn
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [2, 2], [3, 2]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the left side" do
            board[0][0] = pawn
            pawn_moves = pawn.move_list(board, [0, 0])
            expected = [1, 0], [2, 0]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the right side" do
            board[0][4] = pawn
            pawn_moves = pawn.move_list(board, [0, 4])
            expected = [2, 4], [1, 4]

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with friendly pieces" do
          let(:friend) { double("friend", colour: :white) }

          it "is correct with one space in front" do
            board[1][2] = pawn
            board[3][2] = friend
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [[2, 2]]

            expect(pawn_moves).to match_array(expected)
          end
          xit "is correct when face to face" do
            board[1][2] = pawn
            board[2][2] = friend
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with enemy pieces" do
          let(:enemy) { double("enemy", colour: :white) }

          it "is correct with one attack" do
            board[1][2] = pawn
            board[2][1] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [2, 2], [3, 2], [2, 1]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct with two attacks" do
            board[1][2] = pawn
            board[2][1] = enemy
            board[2][3] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [2, 2], [3, 2], [2, 1], [2, 3]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct with one space in front" do
            board[1][2] = pawn
            board[3][2] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [[2, 2]]

            expect(pawn_moves).to match_array(expected)
          end
          xit "is correct when face to face" do
            board[1][2] = pawn
            board[2][2] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end
      end

      context "when double move is not allowed" do
        subject(:pawn) { described_class.new(colour: :black) }

        before do
          pawn.toggle_first_move
        end

        context "on an empty board" do
          it "works in the cenntre" do
            board[1][2] = pawn
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [[2, 2]]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the left side" do
            board[0][0] = pawn
            pawn_moves = pawn.move_list(board, [0, 0])
            expected = [[1, 0]]

            expect(pawn_moves).to match_array(expected)
          end
          it "works on the right side" do
            board[0][4] = pawn
            pawn_moves = pawn.move_list(board, [0, 4])
            expected = [[1, 4]]

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with friendly pieces" do
          let(:friend) { double("friend", colour: :white) }

          it "is correct when face to face" do
            board[1][2] = pawn
            board[2][2] = friend
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end

        context "with enemy pieces" do
          let(:enemy) { double("enemy", colour: :white) }

          it "is correct with one attack" do
            board[1][2] = pawn
            board[2][1] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [2, 2], [2, 1]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct with two attacks" do
            board[1][2] = pawn
            board[2][1] = enemy
            board[2][3] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = [2, 2], [2, 1], [2, 3]

            expect(pawn_moves).to match_array(expected)
          end
          it "is correct when face to face" do
            board[1][2] = pawn
            board[2][2] = enemy
            pawn_moves = pawn.move_list(board, [1, 2])
            expected = []

            expect(pawn_moves).to match_array(expected)
          end
        end
      end
    end
  end

  describe "#to_s" do
    context "when pawn is white" do
      subject(:white_pawn) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_pawn.to_s).to match  "\u2659"
      end
    end

    context "when pawn is black" do
      subject(:black_pawn) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_pawn.to_s).to match  "\u265F"
      end
    end
  end
end
