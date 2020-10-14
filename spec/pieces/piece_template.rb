require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/INSERT HERE"

# Temporary file to help with boilerplate for piece tests

describe InsertPieceHere do
  subject(:INSERTHERE) { described_class.new(colour: :white) }
  let(:empty)          { double("empty", colour: :none) }

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
    context "when x is white" do
      subject(:white_) { described_class.new(colour: :white) }

      it "returns the correct icon" do
        expect(white_.to_s).to match  ""
      end
    end

    context "when x is black" do
      subject(:black_) { described_class.new(colour: :black) }

      it "returns the correct icon" do
        expect(black_.to_s).to match  ""
      end
    end
  end
end
