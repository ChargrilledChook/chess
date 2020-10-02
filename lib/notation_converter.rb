# Converts valid chess notation into 2d array co-ordinates
# Should these be instance or class methods?
module NotationConverter
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
