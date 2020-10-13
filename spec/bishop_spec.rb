require_relative "../lib/pieces/piece_icons"
require_relative "../lib/pieces/piece"
require_relative "../lib/pieces/bishop"

# Temporary file to help with boilerplate for piece tests

describe Bishop do
  subject(:bishop) { described_class.new(colour: :white) }
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
