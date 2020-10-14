require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/king"

describe King do
  subject(:king) { described_class.new(colour: :white) }
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
