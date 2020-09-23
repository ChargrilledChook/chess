require_relative "../lib/game"

describe Game do
  subject(:game) { described_class.new }
  let(:round) { double("round") }
end
