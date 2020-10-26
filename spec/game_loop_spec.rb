require_relative "../lib/utilities/save_manager"
require_relative "../lib/game_loop"

describe GameLoop do
  subject(:game) { described_class.new(round) }
  let(:round) { double("round", draw_console: nil) }

  describe "#play" do
    it "loops correctly" do
      allow(round).to receive(:game_over?).and_return(false, true)
      expect(round).to receive(:play).once
      game.play
    end

    it "works with a longer loop" do
      allow(round).to receive(:game_over?).and_return(false, false, false, false, false, true)
      expect(round).to receive(:play).exactly(5).times
      game.play
    end
  end
end
