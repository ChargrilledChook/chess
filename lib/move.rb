# Experimental move object
class Move
  attr_reader :starting, :ending

  def initialize(input)
    convert_notation(input)
  end

  # Key words don't belong here, handle them in player
  def convert_notation(input)
    return input unless notation?(input)

    result = input.each_char.map.with_index do |elt, idx|
      idx.even? ? convert_column(elt) : convert_row(elt)
    end
    starting = [result[1], result[0]]
    ending = [result[3], result[2]]
    @starting = starting
    @ending = ending
  end

  private

  def notation?(input)
    !keywords.include?(input)
  end

  def convert_column(letter)
    letter.tr("a-h", "0-7").to_i
  end

  def convert_row(digit)
    (digit.to_i - 8).abs
  end

  def keywords
    ['save']
  end
end
