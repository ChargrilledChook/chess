require_relative "lib/player"

describe Player do
  subject(:player) { described_class.new(:white) }

  describe "#input_move" do
    context "with valid notation input" do
      it "sends the correct message" do
        # TODO
      end
      it "is correct with different input" do
        # TODO
      end
      it "ignores case" do
        # TODO
      end
    end

    context "with valid keyword input" do
      it "sends the correct message" do
        # TODO
      end
      it "ignores case" do
        # TODO
      end
    end

    context "with invalid input" do
      it "reprompts numbers" do
        # TODO
      end
      it "reprompts words" do
        # TODO
      end
      it "reprompts invalid notations" do
        # TODO
      end
      it "reprompts correct notation that is more than 4 digits long" do
        # TODO
      end
      it "reprompts keyword start" do
        # TODO
      end
      it "reprompts keyword end" do
        # TODO
      end
      it "reprompts with multiple wrong inputs" do
        # TODO
      end
    end
  end
end
