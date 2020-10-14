require_relative "../../lib/pieces/piece_icons"
require_relative "../../lib/pieces/piece"
require_relative "../../lib/pieces/knight"

# Temporary file to help with boilerplate for piece tests

describe Knight do
  subject(:knight) { described_class.new(colour: :white) }
  let(:empty)      { double("empty", colour: :none) }

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
