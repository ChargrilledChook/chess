# Experimental move object
class Move
  attr_reader :starting, :ending

  def initialize(input)
    @starting = convert_notation(input).first
    @ending = convert_notation(input).last
  end

  def convert_notation(notation)
    result = notation.each_char.map.with_index do |elt, idx|
      idx.even? ? convert_column(elt) : convert_row(elt)
    end
    starting = [result[1], result[0]]
    ending = [result[3], result[2]]
    [starting, ending]
  end

  def convert_column(letter)
    letter.tr("a-h", "0-7").to_i
  end

  def convert_row(digit)
    (digit.to_i - 8).abs
  end
end
