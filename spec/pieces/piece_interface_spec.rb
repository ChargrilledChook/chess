require_relative "../../lib/pieces/piece"

# Unsure of the value of these tests but implementing as per the
# inheritance testing advice of POODR. Simple enough to implement
# and provides some documentation of the Piece API. Do they need to
# to be run by each subclass to be useful?
describe Piece do
  subject(:piece_interface) { described_class.new(colour: :white) }

  context "with valid messages" do
    it { is_expected.to respond_to :colour }
    it { is_expected.to respond_to :post_initialize }
    it { is_expected.to respond_to :move_list }
    it { is_expected.to respond_to :moves }
    it { is_expected.to respond_to :enemy_colour }
  end
end
