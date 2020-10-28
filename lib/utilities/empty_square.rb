# This class exists so that board grid co-ordinates can always be queried with colour
# This simplifies many checks and calculations for valid piece movement
class EmptySquare
  def colour
    :none
  end

  def king?
    false
  end

  def to_s
    "   "
  end
end
