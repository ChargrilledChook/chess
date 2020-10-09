require_relative "../lib/display"
require_relative "../lib/player"

describe Player do
  subject(:player) { described_class.new(colour: :white) }

  before do
    allow(player).to receive(:print)
  end

  describe "#input_move" do
    context "with valid notation input" do
      it "is correct" do
        valid_input = "a1h8"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq("a1h8")
      end
      it "is correct with different input" do
        valid_input = "b2g7"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq("b2g7")
      end
      it "ignores case" do
        valid_input = "C3F6"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq("c3f6")
      end
    end

    context "with valid keyword input" do
      it "is correct" do
        valid_input = "save"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq("save")
      end
      it "ignores case" do
        valid_input = "SAVE"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq("save")
      end
    end

    context "with invalid input" do
      it "rejects words" do
        invalid_input = "fooo"
        valid_input = "d4d5"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq("d4d5")
      end
      it "rejects numbers" do
        invalid_input = "1234"
        valid_input = "h8b7"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq("h8b7")
      end
      it "rejects invalid notations" do
        invalid_input = "a1h9"
        valid_input = "a5c7"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq("a5c7")
      end
      it "rejects correct notation that is more than 4 digits long" do
        invalid_input = "a1h8a1h8"
        valid_input = "e3f2"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq("e3f2")
      end
      it "rejects keyword start" do
        invalid_input = "savec4d7"
        valid_input = "d7c4"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq("d7c4")
      end
      it "rejects keyword end" do
        invalid_input = "h3b2save"
        valid_input = "c4a6"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq("c4a6")
      end
      it "works after multiple invalid inputs" do
        first_invalid = "hey"
        second_invalid = "you, what's that"
        third_invalid = "sound? everybody look"
        valid_input = "f2b6"
        allow(player).to receive(:gets).and_return(first_invalid, second_invalid, third_invalid, valid_input)
        expect(player.input_move).to eq("f2b6")
      end
    end
  end
end
