# Move

# Converts algerbraic chess notation to 2D array co-ordinates.
class Move
  attr_reader :data, :starting, :ending

  def initialize(input)
    @data = convert_notation(input)
    @starting = data.first # TODO: Check if the starting / ending fields are still being used.
    @ending = data.last
  end

  def convert_notation(notation)
    result = notation.each_char.map.with_index do |elt, idx|
      idx.even? ? convert_column(elt) : convert_row(elt)
    end
    starting = [result[1], result[0]]
    ending = [result[3], result[2]]
    [starting, ending]
  end

  private

  def convert_column(letter)
    letter.tr("a-h", "0-7").to_i
  end

  def convert_row(digit)
    (digit.to_i - 8).abs
  end
end
