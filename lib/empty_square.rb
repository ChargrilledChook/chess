# This class exists so that board grid co-ordinates can always be queried with colour
# This simplifies many checks and caluclations for valid piece movement
class EmptySquare
  def colour
    :none
  end

  def to_s
    "   "
  end
end
