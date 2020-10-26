require_relative "../../lib/utilities/notation_converter"

describe NotationConverter do
  describe "#self.convert_notation" do
    context "with valid input" do
      it "works" do
        input = "a8a7"
        result = NotationConverter.convert_notation(input)
        expect(result).to eq [[0, 0], [1, 0]]
      end
      it "works with another example" do
        input = "c5f2"
        result = NotationConverter.convert_notation(input)
        expect(result).to eq [[3, 2], [6, 5]]
      end
      it "works with another example" do
        input = "a4b6"
        result = NotationConverter.convert_notation(input)
        expect(result).to eq [[4, 0], [2, 1]]
      end
      it "works with another example" do
        input = "d3e1"
        result = NotationConverter.convert_notation(input)
        expect(result).to eq [[5, 3], [7, 4]]
      end
    end
  end
end
