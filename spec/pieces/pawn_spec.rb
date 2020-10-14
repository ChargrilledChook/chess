require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/pawn"

# TODO:
# * En passant
# * Double move jump bug
# * Unsuccessful double move bug
# * Promotion

describe Pawn do
  subject(:pawn) { described_class.new(colour: :white) }
  let(:empty)    { double("empty", colour: :none) }

  describe "#move_list" do
    context "on an empty board" do

    end

    context "with friendly pieces" do

    end

    context "with enemy pieces" do

    end

    context "with enemies and friends" do

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
