require_relative "../lib/utilities/display"
require_relative "../lib/player"

describe Player do
  subject(:player) { described_class.new(colour: :white) }

  before do
    allow(player).to receive(:print)
  end

  describe "#input_move" do
    context "with valid notation input" do
      it "it returns correct co-ordinates" do
        valid_input = "a1h8"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq([[7, 0], [0, 7]])
      end
      it "is correct with different input" do
        valid_input = "b2g7"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq([[6, 1], [1, 6]])
      end
      it "ignores case" do
        valid_input = "C3F6"
        allow(player).to receive(:gets).and_return(valid_input)
        expect(player.input_move).to eq([[5, 2], [2, 5]])
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
        expect(player.input_move).to eq([[4, 3], [3, 3]])
      end
      it "rejects numbers" do
        invalid_input = "1234"
        valid_input = "h8b7"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq([[0, 7], [1, 1]])
      end
      it "rejects invalid notations" do
        invalid_input = "a1h9"
        valid_input = "a5c7"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq([[3, 0], [1, 2]])
      end
      it "rejects correct notation that is more than 4 digits long" do
        invalid_input = "a1h8a1h8"
        valid_input = "e3f2"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq([[5, 4], [6, 5]])
      end
      it "rejects keyword start" do
        invalid_input = "savec4d7"
        valid_input = "d7c4"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq([[1, 3], [4, 2]])
      end
      it "rejects keyword end" do
        invalid_input = "h3b2save"
        valid_input = "c4a6"
        allow(player).to receive(:gets).and_return(invalid_input, valid_input)
        expect(player.input_move).to eq([[4, 2], [2, 0]])
      end
      it "works after multiple invalid inputs" do
        first_invalid = "hey"
        second_invalid = "you, what's that"
        third_invalid = "sound? everybody look"
        valid_input = "f2b6"
        allow(player).to receive(:gets).and_return(first_invalid, second_invalid, third_invalid, valid_input)
        expect(player.input_move).to eq([[6, 5], [2, 1]])
      end
    end
  end
end
