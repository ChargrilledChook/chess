require_relative "../lib/referee"

describe Referee do
  subject(:ref) { described_class.new }
  let(:enemy)   { double("enemy", colour: :black) }

  describe "#check?" do
  end
end
