require_relative "../lib/display"
require_relative "../lib/player"

describe Player do
  subject(:player) { described_class.new(colour: :white) }

  describe "#valid_move?" do
    context "with valid notation input" do
      it "is correct" do
        valid_input = "a1h8"
        result = player.valid_input?(valid_input)
        expect(result).to be true
      end
      it "is correct with different input" do
        valid_input = "b2g7"
        result = player.valid_input?(valid_input)
        expect(result).to be true
      end
      it "ignores case" do
        valid_input = "C3F6"
        result = player.valid_input?(valid_input)
        expect(result).to be true
      end
    end

    context "with valid keyword input" do
      it "is correct" do
        valid_input = "save"
        result = player.valid_input?(valid_input)
        expect(result).to be true
      end
      it "ignores case" do
        valid_input = "SAVE"
        result = player.valid_input?(valid_input)
        expect(result).to be true
      end
    end

    context "with invalid input" do
      it "rejects words" do
        invalid_input = "fooo"
        result = player.valid_input?(invalid_input)
        expect(result).to be false
      end
      it "rejects numbers" do
        invalid_input = "1234"
        result = player.valid_input?(invalid_input)
        expect(result).to be false
      end
      it "rejects invalid notations" do
        invalid_input = "a1h9"
        result = player.valid_input?(invalid_input)
        expect(result).to be false
      end
      it "rejects correct notation that is more than 4 digits long" do
        invalid_input = "a1h8a1h8"
        result = player.valid_input?(invalid_input)
        expect(result).to be false
      end
      it "rejects keyword start" do
        invalid_input = "savec4d7"
        result = player.valid_input?(invalid_input)
        expect(result).to be false
      end
      it "rejects keyword end" do
        invalid_input = "h3b2save"
        result = player.valid_input?(invalid_input)
        expect(result).to be false
      end
    end
  end
end
