require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/queen"

describe Queen do
  subject(:queen) { described_class.new(colour: :white) }
  let(:empty)     { double("empty", colour: :none) }

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
